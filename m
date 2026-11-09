Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2F6606D81C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BDQ4PXlX;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=PzRNVR9R
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9249340774;
	Mon,  9 Nov 2026 14:43:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Po8Y9J7gc3Sg; Mon,  9 Nov 2026 14:43:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C290440763
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794235407;
	b=AcwnUrhztZ6atWMQntfSgWHVaN3bU/meqzf5V7UsUa3dmAulxT80TvPnhniZigOYO1q8
	 99gw8CZb3WXtUDzY1VPacI0JhkOAGPkzr5Ip4BW9FpRLfCNT//lenOldQVNIiXA0gNNdj
	 cnFGjXiD5cAdVb2jYBKaHzHUp8NToEWn39dyLcEDQuD0sXMq0Oydop5Pn3FWzwGTxYdu+
	 ClWJo3zP/v6z8cxLvoAtaC1CtgYcrHR8nwrY2+uNWCp1u2yQjm4YyDfXSmaI0w5MU1BMT
	 /zwq905sl2aCCPHz178x+utVZkSIQZFusvYg807kDqeRFM0Tr2rE9Y0A1EznR/IM2Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794235407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=079j4EZGhGYJAfatqnkt9CTx14T3J3oQavVkPsyNO1w=;
	b=PzSmVYghrSLE2U+SCjvXqOmGzggs4UqpW2R5Lj16Y0NdKvngcaF4jvc4QwEuMTgyK+j5
	 XDSl+I6nI+X1mDSF9xAWBXrG9SMSvW9I50glVLdnjgBj9DImvywHx9/TJ8xUuS5Q1UI15
	 9A77iFIFDfY0IM18+j5oY3UkRNv041syfFCNurwVGCFDv75f65gFrBOKij7ZmPheFdArO
	 1IklOMDpnO7+pk07YKKJhtrRoVWSQ+G7TIeOeLNqFg65aDkey83hMyY5/xddFm8KGW8Y8
	 NNDLI6VFmaUSrOSS3+XPsdvimCRuciIGuKLiPr9klb1/m7hQKpkPegW31lHwTX+0oZw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794235407;
	bh=079j4EZGhGYJAfatqnkt9CTx14T3J3oQavVkPsyNO1w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BDQ4PXlXbVgsdDzFUfwcu6jlkfuCNgDSomoXEo/X50Br8wgDkZdlaY9BLRZMHQ23A
	 2uCrlgfmzsXSE3u4iHDQT+Aj3aHgLWz7tw+yWEVnC4gcED/JsxVVWRwiUCggO1eosp
	 KJNCWgWQtqI7v0fDwOoP2dZDmWgxdl56u86aO1J0dQ6zJS2FrEeqUyqAnlhrpGJDUl
	 6pWtRsV5WzZJAhCpWnm45bdjlFQ5vH3p9jyTNGOSgFK1b8RnEgl+GN+9NbiUN8vIXJ
	 y/+AiKFjNiP++dEd5aVeOPPsdbZRlE6jMiZK1jgyj74DYJYC+aOqrtfONVdJ+Qgbq2
	 /gXLSG780auXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C290440763;
	Mon,  9 Nov 2026 14:43:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CE9B1235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C086860741
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XmNXqpwfRG5j for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 14:43:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7950F6072A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.125.25.15
X-Greylist: delayed 1224 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 09 Nov 2026 14:43:24 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=PzRNVR9R
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.15;
 helo=smtp-190f.mail.infomaniak.ch; envelope-from=foss+uboot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7950F6072A
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 14:43:23 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jNXZx4wmCz1xT;
 Mon,  9 Nov 2026 15:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794235401;
 bh=079j4EZGhGYJAfatqnkt9CTx14T3J3oQavVkPsyNO1w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PzRNVR9RaDv1oiDZX8SJTDdi0zT96bTLEtgA7/vmURk5f6iC+EV3tvLO5KcADv342
 LY1JvB6kzhpq7zgHDkQc9Ff7GrQ5xzY9/ODpiKkxjFeP44wsK2P17RwbVyJz1k4Hjc
 PdUBpYGA2FTeGRcwEoCL049lJlnmcmie2r88hXbVv/koP85GC6vJE7My8PoKk4x2vE
 /q/4RJhZ1p56DpCNluK+okU5u/kqR7OkDcusgZ2DynFF9vvE9nCnUjctTm1Zlk58Xs
 SJYwkJIUcIFRFgS2peazRklkKXtsILpkmx+AGl/Ili6IYFA01JFk2Qg7BA+pMExYxg
 Sg4+j3vPPZzQQ==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jNXZw6LhXzsQ5; 
 Mon,  9 Nov 2026 15:43:20 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 09 Nov 2026 15:43:09 +0100
Subject: [PATCH 2/2] doc: board/amlogic: jethub-j80: update shop link to .com
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-linkcheck-follow-up-v1-2-64ee7d115a6c@cherry.de>
References: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
In-Reply-To: <20261109-linkcheck-follow-up-v1-0-64ee7d115a6c@cherry.de>
To: u-boot@lists.u-boot-project.org, u-boot-amlogic@groups.io
Cc: Tom Rini <trini@konsulko.com>, Vyacheslav Bocharov <adeep@lexina.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Viacheslav Bocharov <v@baodeep.com>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Quentin Schulz <quentin.schulz@cherry.de>

Use .com domain as suggested by Viacheslav.

Fixes: 1a33ee41ecd2 ("doc: board/amlogic: jethub-j80: use redirect link directly")
Suggested-by: Viacheslav Bocharov <v@baodeep.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/amlogic/jethub-j80.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/amlogic/jethub-j80.rst b/doc/board/amlogic/jethub-j80.rst
index c3800f9588aa..2e8b9a5dddb8 100644
--- a/doc/board/amlogic/jethub-j80.rst
+++ b/doc/board/amlogic/jethub-j80.rst
@@ -3,7 +3,7 @@
 U-Boot for JetHub J80 (S905W)
 =============================
 
-JetHome Jethub H1 (https://jethome.ru/h1/?variation_id=56) is a home automation controller device
+JetHome Jethub H1 (https://jethome.com/h1) is a home automation controller device
 manufactured by JetHome with the following specifications:
 
  - Amlogic S905W (ARM Cortex-A53) quad-core up to 1.5GHz

-- 
2.56.0

