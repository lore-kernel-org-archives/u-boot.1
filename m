Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4155BC79F9E
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 15:04:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACEEE80AF9;
	Tue,  8 Sep 2026 15:04:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4pNkzxfmYvCT; Tue,  8 Sep 2026 15:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8734B80AC8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788879890;
	b=GdxiE2NpDZo+E2eBrUJVD230Vj1cIYLTi1RsTaNh9iblwDmCobeHxRToyKVyxn29R69w
	 2d3TMKKEGICLr/bK68jOMQ431ITeQ3U/ocoMa0wXuZ0vWabG3vGVkb9dIR+HR3JWp9meb
	 IxEeqESLYQ+ndhsF27Rr3W8B0uO93ul6kdpHgyS6i9XI6//lRNJ6v8mSvyO5EQY+6pDl2
	 s9y+mQDjAdtnAlZSLRzJGXbFy/LTNarfuvMSRAuotejWzCxWzwhZcwBueePgoqAM761aZ
	 dE7IiDuiEe75rUzW/cFVGApl4wevDdrfp8kt9TtGtJc/s9fpwrcHm/Zf1SKe1pDCd1w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788879890;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k+sFBicITg9bgxMy3VdwzQZcNuaQxWiJUt/sdAFxDa8=;
	b=MEaI0Nm7RHYg6SPAZOJi5UtkAAVXvzQshQSgZ/hOFoifAWJevnbva67tfXt0DlFjzPiS
	 10Z51OVRFFzwLlODidm78wA2YSEOAetRvNAvJNs2zMhJNxT+FhMRKZ4fImALq0Upzk9YZ
	 80kzfnUgI1n1sOkSLbszwemu0qpb+yFIGFwcO4VXxxSIl2Qxg2dbbmAqqO8vJWG0i8MsS
	 JHMRcUtXzJK3m5THeUcYy81Gywfi1zvjr+oEv2vUUHhkrc2GoTts2kluSN9AvjD7t+1T4
	 YQDCAyAgziaPhQP1QZnshbb8Rxg0Zf/qOLXhdCIxooVYbb8rzV0ki9VccB1uQFhjw4Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788879890;
	bh=k+sFBicITg9bgxMy3VdwzQZcNuaQxWiJUt/sdAFxDa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lMW4NLlFQ6fotoP0FtHyFQM0aeXvxXvHhd0mi7BXjZcWOqF4vMvM7o5psv7PhC7KQ
	 wGwJuEQe9DApzPV0Kq5xehj/Q4L38yLhxNgo5dA2/jOyHeAw5IMq8DnbgVMooie/6b
	 D9HfMEyaNRwy3KDsS6/7lMlDvGNTxm8EgGYtahpoFm3ejQJ77NRhXeZoUcbqTIRIX8
	 IY9NSVYFitre/amWt07KyNp2q4knajYo2SL5UPx+oKa9/RPczqWOxyYGswqpmNBNcX
	 /vTjHo61VyC8BZie5OhqdY+nkRUyw/HtKvxT/LjMoDqJmVfQQbwjnCcfrNmPEnRh9W
	 Dxds2hBTzoKuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8734B80AC8;
	Tue,  8 Sep 2026 15:04:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AE1CAEB
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 204C06071A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mJgvhSdutCie for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 15:04:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3034260718
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.136.65.225
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788879887;
 b=DxGaPKAaO9lJIWBUUcW8Sk6CyTWHplb4KWpgOHhd/6KdyBOaLq9Vy7gK1euI4ch3QPrc
 Eu4R69X+ZSS1jauIbz5S7dj2NHuQTatHe6Dmf1N8gJY6myISoI7qv4qwkkoSLKKwQFwOM
 EhyXxgibzBnop7FjUMLliwOUs24k7GIat1RQJDlnK/0vxb5OLU6ezx3K0NMIP5cruh5zw
 +/K4uMv5bMyeZBiD915LdgqTk82jdeFtrlH0N+iZMsTsVsaCjfLi1KSR1XnGm0d4ncc/r
 0xfKgazK0qkBWK+eVPICjIqIlhZ8bykqqSqqD9i2djobBxXjyh5WFPKJXQuILhHGYdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788879887;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=k+sFBicITg9bgxMy3VdwzQZcNuaQxWiJUt/sdAFxDa8=;
 b=UgTuWSHv819cgtzcpr0JpWEP0xpuTTmkDCTSxYFd85Wjx4cc0Te3vi2KkvlLzNFHgvD0
 LfdFvgbs0htnyzuTbJYUATxgXQ5gFsKYwL2JJn/m/cNQwG9FTUZqQLxJvUnZy7Pnq9L4x
 /0w3bXx+ob0OAll+f/gh9NFnYZ2W9+RIFCIdjgNLMromeTj133lGGZMXSchIU/U4lPjd8
 sB+OomOxU5mJsI+6LpgPSwU0c5Si9PAQ2Cl6yOF6g2JndBejBYuxd775N9CvNe+M7fCMl
 EY0uCMbqEN2HSN74sqbdrbuwU5zHO+k318JS+A5ud0W1YQ0Kt7V966CvOmSKiInW/LA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=fW4oFJai; 
 arc=none smtp.remote-ip=185.136.65.225
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 08 Sep 2026 15:04:46 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=fW4oFJai
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.65.225;
 helo=mta-65-225.siemens.flowmailer.net;
 envelope-from=fm-294854-2026090815033902f62ecf230002074a-bqfec_@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3034260718
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:04:46 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026090815033902f62ecf230002074a
 for <u-boot@lists.u-boot-project.org>;
 Tue, 08 Sep 2026 17:03:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=k+sFBicITg9bgxMy3VdwzQZcNuaQxWiJUt/sdAFxDa8=;
 b=fW4oFJainU0UEnOxBYcNPeIyurfn9kV6aEQWUorzUAUEt17lx9zZk3CnWeau3wD1a6rKFY
 DX4YkeiZcPHaNUis+JxXTUOphcFJls+JfVny8Y9GiKIJz7Tac0PGc5PTIsQY9LvH91TjHdoV
 0DnavlwI2FnKr9zjZGAqq9NdGFkxp0wW+kJEql3UWQqB9F3L+i7pDVzSXtDFm1spBZ7ATCGv
 V5FAMiFNqCT4uVSxxBzS4EH3XFJFQ1T94OAfKudhslEkzNcOF6i6SjAb8ZAOmg7zTkEnS//9
 xZyw1V8Z64rNrKu27AbqGApeKbVv8kOkYQlr20l6Su+unoa0EMlaOFIg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 3/5] tee: optee: Do not warn about
 TEE_ERROR_STORAGE_NOT_AVAILABLE
Date: Tue,  8 Sep 2026 17:03:36 +0200
Message-ID: <a2abee8c3f5f41f313292b8d9befe71f5b97ec34.1788879818.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1788879818.git.jan.kiszka@siemens.com>
References: <cover.1788879818.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

This is a transitional error that is resolved once an RPMB becomes
available. Keep it as debug output only.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/tee/optee/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ed8f2b6ec74..d3b5811afb8 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -106,7 +106,10 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
 
 	ret = tee_invoke_func(dev, &arg, 1, &param);
 	if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
-		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
+		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
+			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
+		else
+			dev_dbg(dev, "Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);
 		return -EINVAL;
 	}
 
-- 
2.47.3

