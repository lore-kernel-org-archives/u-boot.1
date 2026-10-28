Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090A6606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mb3yasBE;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o1PaygKO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B106480CEB;
	Wed, 28 Oct 2026 03:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o3QNPmmqbX5Q; Wed, 28 Oct 2026 03:07:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 80D0480D00
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793156848;
	b=VMJ4e86Ta2gCcMw/Qm3kYbS56mEtKDXEvOXsbz8PBItkC021FthTpMwlSqtpyLLzWnv4
	 Gubwyx5rc5OLqtPSXsCAUKWSAJyzKFe5+Luvn0OWKcUsr609d/SW/Atw32twrYF4LT5Ao
	 29bS694UVL4ChSmf1rdciQOhUUK8d1vcO2fjZxzMc5pzOumYVUjpaNCMEqud8XnolnrWJ
	 fp91W7o7qfsMGpe6hoS949lRFxx+iZ2+gLXvaNstVDZj6FiPm5R6uaZ9xpefgl/n52lpg
	 8GXnnK1BeUqMO4AKmhCElE95vUfA5feUfBv1yq6MHDKfgUtUiLP9a2KfNKB9wXui/BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793156848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sq+cYjH6ZsQsXKM816/V0niXkSHMX5iFdJTkQF79+9w=;
	b=Qqtj4C/xyDMF/46KamG+1LSdqgzUyTnClpR4mE0RulF8lOHas4ZS7hgwiYYzMA77rAdz
	 2ACOCrDtcn8QL4H/s7t5muNN9TJ51s9Glp6T/yZTFzVraHzKKQ7L1sq3Fnf2IrdskUoQf
	 DncbBQzMNF/n7lS65HTk8lfziI0SLHsasRlMTzcaqBS8fB8jBOqacTetrR6qMyaALzXcw
	 puelWDreqhgfjtVHZ1nUU9EDK0gn17j2vxUnhcsOAcRrEX7mfJZYrF82g5a1lscWKHzm6
	 T4vOEmrbwWxhC1/rE0IGInljDVi47O5zrlwA2bWq8twPncF/N5CIPPG61CZeIy27A7Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793156848;
	bh=sq+cYjH6ZsQsXKM816/V0niXkSHMX5iFdJTkQF79+9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mb3yasBEfBL9dNAV7OAHXfrKo3VYnIid2LInJiY65dooNm4UoJhwWTEasZoxWNu+E
	 cFmBZA8sJQW/PNXo6Dxy2hjB8L6bk8qIfnSotN5hhaha74XyG8baeJE6QSL8Ge1CUW
	 /SItIT4GPLC8rP/w4JKMcNHmYSlbzmfLmbBMvvVzq/Ws9Xf1IfjQwB7QIgRAXBjOni
	 /k1k2J8og7qKT/otx1xveBCk9HUjDhDyNBlXtAF1npl4sF+mSbnlROAneb9Rh+rahZ
	 2SuVeigOmQ0dVbr8DJEjrcI4jNqehHXxsFauIvdkiGnAhVdxQqHxROHv6dfG9sX+fs
	 zqxf4IRisrEqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80D0480D00;
	Wed, 28 Oct 2026 03:07:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB9BB4BC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D2F64056A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2vQWwn63dPc4 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0FC0140567
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793156845;
 b=JemnyXr4nX8TXCxdfwvt3AR5PqTn1i9Vl7HUfZfyz3H0yp+iuPLCEpfgBtS4XmO2suxw
 bgH6gufHHgFxhJXyCfs8xMjLbeqPSiETNpFbCDX3GKq9N8snjkNB+ypOaGzwtrG3Gbd4b
 7Elicc6tTC9Yj0bgzq4n05qC7A7qVv50tZ0uW5tIj57ycz6tCm5ok8nU3xg+MBTvgcgXg
 /bMwVquXPa6wd3SHW32Ga1B9zQG1BsaEGyWTOHWdFmCWCO7+OiKi1RXFhZiCLYS12UJ4S
 HIvDueIRAiZfhSsUNj2idTbFbh8XtGhZFqEp3wSba5ZwR5BNsVroesoTtb0zNQju2YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793156845;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=sq+cYjH6ZsQsXKM816/V0niXkSHMX5iFdJTkQF79+9w=;
 b=sj1F2sOoH8VVebNCuMSMmw1TKa2EJLILcAXTR87kOC/AM6VoNOQtdRs0C80yty3MJV+S
 uJqdnxbiCJFU3Q6lcViGmlZVU5IhPXenKL7oCsoD3KdpWuZS6Qxf85sFmwtIPySTPUj2x
 T2lrvHeT687GdxptNombl1aBktGnFCoGyiY3h9oBe57NkUqbPZST9vV+qzEtWuA51YRJe
 q3b4tmen6UsTIFHZkgIYbaF3jMHyOPBACO+u4WE5rTBBt0wZL26z7VfSCn4bdZko4KKQW
 94nuH5yTT2AxKoQ8WywXtMfBVoFi2AJyaktJOiSCFr/obBkswirQJVPTkJAkWX+V/eA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=o1PaygKO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=o1PaygKO
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0FC0140567
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:24 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e987a2ba0cso2603955ad.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156844; x=1793761644;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sq+cYjH6ZsQsXKM816/V0niXkSHMX5iFdJTkQF79+9w=;
 b=o1PaygKOAX06gb/lo99rqnRY/8AxO32nea9rn9WyytBSpnyuQXOl9e6oDV1RiTfHl7
 4CGojq7KzWdW6EjhzNtmhfoseogbm7nIjibiO98ZdWdxHxW8Ff7gResWx+P5fDLAob82
 kN5gbKJAOQeSy0sSQAnykIkgj4oUxD1GQb9bHUXkuAuipk10v+WGQr/q0ftqCMjUDby5
 evdJ8Xpia3Xu0WfLFP/3/qvKAbHD4MIilHcFSdRkRVBcupVeSrFXPPSNLwXCWNpE1Juz
 zvASkzuDTJjpem6fpqnio2kJR7hRe1aeALIFvaRxvDPz6S4PHJBALl6T/02ukFyCpuLC
 Q/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156844; x=1793761644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sq+cYjH6ZsQsXKM816/V0niXkSHMX5iFdJTkQF79+9w=;
 b=K0FY0Cq5E4YZ3Q5W39jLaCSoVtBNZf5Sx9wpx/+izOGgez7oJpbq+8/SQBKTofZcWU
 HlTuNGcuFxwQ5r//CuLJHcNph8SX0UbT6Cmi+ReKbQBmaqZxCA93vLju7p2z87QvSUBg
 EmnW5XKkAVrqeF0I800E4dBtZubswHZTI7Vz+9wIpYqAv8bZ4RXvUvNlR4Es2Ybi/Miy
 Krr4a7WBPwtvla6D12qU2FuYxztkq+q+0CPU2zkZzpipJMQck9djs7X6JjSho+OzZpdN
 4rSJjGl3yjSaBbExktwN41StTscsSIwaQiL3+umxUkPFAKmw6p6Cg4Om0e+lLCMToPWH
 PUKQ==
X-Gm-Message-State: AFq9FYL0/OTyjjzGP7htRSWG9pX6F5jRYcWbr18C9z8fgjcLLFS2JGlP
 TH75S1HeRkd2ix+LbF+7AFHWdPuZnCp0TPwq+k8wsimkvwufIGjNw0UP1VO4XCxW
X-Gm-Gg: AYBFou0py08X9s6dKCfI6DMFs5yde7HuS6jTbKS3kAYOAha8uPx3Ug3ZyTiUsrFQzAp
 Z7BUqXGwO+/fyOE+tM8VrqvnQmn4cpxR3XvqK5kgi21SkiZX7m958BzZ2hZ8inm40nT/Kd1RSSk
 l8n7vRI/sB/l4tNC82za72Go+mG5Sdy0ds+W/IYeS67+HrE5xATMF5PdE6OUm0DDnORlnpn8ldC
 zYnSk/Yhf9CUZh9mn0idiviP6RaBoruRRrMthYmo5+Hz2EvRr9qrhWeq40kR/fJINBsu+bR9+Jt
 dhJ1OHQ+BiAUQLAi2KPP1wjHg0CbH2boySqno5QXafUa/EhCCYioImHzRjFbifZFi4AZWXDlOYe
 feECALOYakkWwP82jiogfDFhEQFpMliYeYrSIEs1uef1W6HbUIiZu1bM0adVM5OQhdCzWbyrSJP
 sRFhe/dO/QITlC9O6IMNGVubldNa1dZTqEJ1bfnGywRvksk3T1CgWUWS8/uqACiHwzOIJudU0Dy
 ruoTHARx5Ez23Fk6n/14N6yYWQa8iuEmY4xZ0kp1q4QYisDDDtE2TAfNZsapnFoAmSrLwrrRG2J
 W1yq81TcmNkJQlwTHBCeMDgKsDk18NiAZxttBYN3JLseNYnVIryhXsR1VYPE/3zMTexZPvvOTXd
 IQ/rHswKh7rA3AFBKIo9cf4DtJUagJ4otZCc5aZrnU3PTBMQmhWv/Qj4R8dIgiyE4arzgHIo5W8
 V9oVqb/Yzz
X-Received: by 2002:a17:90b:574b:b0:3ac:7116:434a with SMTP id
 98e67ed59e1d1-3ae580a7f31mr759646a91.15.1793156844093; 
 Tue, 27 Oct 2026 20:07:24 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a48c2c5sm828615a91.4.2026.10.27.20.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:07:23 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de,
 Bin Meng <bin.meng@processmission.com>
Subject: [PATCH v5 3/5] MAINTAINERS: Add entry for virtio RTC
Date: Wed, 28 Oct 2026 11:07:12 +0800
Message-ID: <20261028030714.1608977-4-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
References: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add myself as the maintainer of the virtio RTC driver.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v3)

Changes in v3:
- Add test/dm/virtio_rtc.c, which this version adds

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95b1f3b5a..23a232689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1885,6 +1885,11 @@ F:	include/virtio*.h
 F:	test/dm/virtio.c
 F:	doc/develop/driver-model/virtio.rst
 
+VIRTIO RTC
+M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+S:	Maintained
+F:	drivers/virtio/virtio_rtc.c
+
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
 S:	Maintained
-- 
2.43.0

