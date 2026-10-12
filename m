Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338AECA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 05:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFB2380CF0;
	Mon, 12 Oct 2026 05:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qhw3WccZqF1J; Mon, 12 Oct 2026 05:37:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3CC1D80CE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791783422;
	b=g92bPUQR5aHmwGcMOWFZtv+VC+8tWYE574CN1mK17VqoxYSWWR0od9nntG6UO9Qi7avr
	 S4dCtochHH3jXFu1svybzwjXMSfBHph8VWSz1+wvw/5jJXe4RYxTJrRrrN3DopyvJP+gp
	 +iMOTOG5Fqj8mQVOCxcUg+ajlW57Z6j1hzHq7iF0wWimB6NdbUD2/fdmrCI7UT4fHLp0p
	 hMU2bO78B/C/SqOVwEzTdSk8NDA2iOa8aaNxEDMJWH3tlCOACWhWNznBN03D9PFEtaj9R
	 2k7/jdamPgXeh//F6ikOicfPRoXOMzFDjfmDZZiqoTRQD0vUrnnFjlDmOwZBz/B4JKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791783422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
	b=QCqouuOpAMz8DGxs0U+BvghuEBEzpEWUbHzgxTQ/P2Hem+ZkZLTEw4wYPim6izx3FRAp
	 x9wUf9/aUAHbS9UZllEit6dwpk/2Z1QHoHTiZ7Z2zYq1nxNG3DofNa2w+EdASGao61GVP
	 lP5BEmL+gYaq5EH6ifEi++2i7VkjvJgrye9mI3XioNJOF7V15r+kKL+OOCcHUNlK1N2DW
	 r4/LIM21xgfy6jCIBBRkw0nY5OMkee3769DQYDEeD55OcQkDACNCgSjGI5ZXj2Onae0X5
	 F7GXjbFaAhS9xUSo07Pa9r0DeBwS7EK5G1CtfNVVFQSl5h7lfdOgXkSo2Di0OxkxhHA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791783422;
	bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iad8pzmQlFMTanMa3UZNRI8P0KVUxV6e50IqQtdm3UfxwIlS2JVLCymDF9kA4pMHs
	 KXwKrMNBtmSmslYBALVnQoEBZsWbkyXNJA46gH/pfsaIUuozTLV+i8AUjhzz6gpTnr
	 KDojgtyqJo+wi/pBFaqdxK84W42mTLHO0GhaGBKyTdLsDBW1zMUU5EDNT/7rpnJ/ii
	 nz9qHN9wcRYY8PTZNgFC6iVDp9xhcsCPXioh8KogVIsVopj22ytsZFBDp1zpUwangS
	 SOqvIFBQXcNk7P446iFKCBQ7SHuey+0sxG8feDylKe7Pc4xax9mLMH6ZZlOjZIy4zo
	 JrkyHOKQl0fLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3CC1D80CE8;
	Mon, 12 Oct 2026 05:37:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 702511A6
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61FE040556
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLJOnIyF5Y4Q for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 01:57:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 907B540543
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::933"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791770245;
 b=ajV6aTrg7T0WocDzhi2tokN6ru9cl2OJ1WGiG8LzJgTFtkgZIxSDcR91ia1+s1BY6CtD
 Qr9Lu58QMh76uAyWKQ5nQJ+9ZodM98Z76QXZoB8tQM9OC+u85mL7BSUACVT6Ifr/A79NV
 qhUSlEJ0EmIKNtOy9TbFGqjkOARSMf82mm5QGYkmMaCzUify7A95shiRyixKx2xjAyD1y
 zhLvUgXeQYxgc1F/tbWgB7WW3oF7XGCp0/Ph8hEbYaslm+Bvq0khE47YPWzZhBdcUlnwD
 V5nyM5lBk+nKNNV1fVnB7n3yJ/w6kpx4l1GTuBsDFOOJrhKKrgYwQ9DqSUiT/vJQAwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791770245;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
 b=BH/LyhRjIEOeiSS8M9Jz4HhLaaLtHEypOCDtsuOuc99aRtviMyaynsfyAyLsh3fRFDln
 rgENgIDbO2ftXxs+b2xwMsvnNaW/XWhYq3LxqVazTm45cx74Mh70VG/RA/xry4m6+gE7S
 7ztEJUE2jrU/wVJUiXdG7ZS4jlADmul0rejnXkJ25O73+jYmIbsJar2MALnEkOvvavxEN
 T2nFdYtUJAB4i21kzIPnBJQQ+3psRVO899p2My9t5njDfVMM6Qc8R3gM72K2SSeb44wM0
 sIgD0sJGtg4r6Q7bPJzPXj4nzkjvz+pJ+c02VT28ZsKtuxISBpUxP0stqQYPU7YR5Sw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sj+p0zAv; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::933"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::933; helo=mail-ua1-x933.google.com;
 envelope-from=sebasjosue84@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sj+p0zAv
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 907B540543
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 01:57:25 +0000 (UTC)
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-98929bb8eb0so327195241.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791770244; x=1792375044;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
 b=sj+p0zAvJ8cnSoWvPeSM8Uu8TFRGbSC8xcU3u4/XkwGq4FbJDN9U+/l2suyTPilYvB
 xjVtrLXbRPCSO+uTlAHB9x6FTIVVQ3e7etuVy9AA/iuBHQGSq+vCjta19mKrFhd3+1sb
 PIq9YRJaNpVY1LnUhMx+r/4eU/xdzZa0GGV7CV5gtBwE2wf+0AK85jVuWxw5FAK9Ch63
 EgoWKPd1zVoO17g5x/7pgaCXi1dm8/b6K0AYsJjLsw49d21NPJmhNxnKYHUDwTTuDRUp
 xAnAHcSSl5RE+gl8R10s6qDa2YoqA2CjkqiwbfnRKtIiGYJBrTCBkN8PDlPGBdA/5hGr
 YjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791770244; x=1792375044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
 b=Qa5oK6SldhHq/v+KVUQmm+GcHAiccsGUoaBv84vvjPkZ6wwYl/htWgKiJj/BRbzWrE
 +1fb3BRJ7LPS0+ENtrYANbo37SkACHdfWGArVdvFwhvA11W6R1qiyajBV8BwOdd1Qi44
 wHZhyaES7BAZk/i3OYNFbQIw/XfyTDDcAij9jOFWU2JBs8bNKOJVa+F8kzPKcr6fa0oB
 +O2O0Grv1PkEZxWWfJhnXfe5EUhYQ2CULSWSnf0ikKrRwP5zX7/KgqcFJbg/HYacKtho
 bFvT0zoeksO0aIpAHVVWasDRDhcJbcWeoA9M3rVI21mKKXqPWvLTLf4Gr96Eil/7s9nd
 ALUw==
X-Gm-Message-State: AFq9FYIpE3AbgQIPWRpw0IDyG9Sj56onSmAd2LIuC439GN1Lk15L1ty0
 vBhLIymQXbR2nMFbzTPXJS0pWp2dY9B8yy9kiXa8EdvLcK9stnzJoyl3BxL1UastBxVxDQ==
X-Gm-Gg: AYBFou1Ryf6JbzaFYhplvXhVhhpyrIQ9drJEWzO7IdZodISSdTL+sZohTIwsptFIQ73
 ZJFbMImtUgXiE/q4aHBH4GotRKzJJgi+Tmz1FJP32JtyO3Ystnadw6v+PcdbtGyA5Fh6rPbm6BQ
 HKPGKG1fs3/JybJVW6J+ga1DtMjwMCxpmY+4ALAlbaPdRpcAVIcmUtntSpDV85jy0HbfxXYz7vJ
 /e4AjskwQnH12RDQMnwX6vSUspC4TDehknHKxs9oiHmCAmY0mjqL2TIDN02Rw0vV/gjX+sXbJw8
 OgLJIUz1t/NVIc5nEocdacIXLerhdGLz0qTik6s4FMyuJ0zn3q7vbCUj8st0flPFQi59q54k0Vl
 Lk7Zefeid2suCBSv/C4UMjYGagjjZYVTM1csmdJ5pkGVWz2nKKeV3/86Ftk6rNBxx6p/TawMjPl
 U8BF1TaccuUZGEu0+G0jc+37/gJ/VnpmmM2JYteHRdzUluU8xyhRcEzj8A+GLbppAl4gATCey5C
 D6mjDfbPE7jS/uSKWR7AwDtMMMRKIC5iwOo026FrRsUKMpqwcCGEuKFO7saS5U=
X-Received: by 2002:a05:6102:5122:b0:7b1:6028:5475 with SMTP id
 ada2fe7eead31-7cb372824f9mr2213382137.12.1791770243999; 
 Sun, 11 Oct 2026 18:57:23 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5e93683455csm3457882e0c.13.2026.10.11.18.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 18:57:22 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, michal.simek@amd.com,
 Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH 2/2] spl: opensbi: Check the return of the entry/load lookup
Date: Sun, 11 Oct 2026 19:55:42 -0600
Message-ID: <20261012015542.1156811-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012015542.1156811-1-sebasjosue84@gmail.com>
References: <20261012015542.1156811-1-sebasjosue84@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 05:36:56 +0000
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

spl_invoke_opensbi() takes the next-stage entry point from a
/fit-images node with fit_image_get_entry(), falling back to
fit_image_get_load(). fit_image_get_address() returns -1 without
assigning the caller's ulong, both when the property is absent and
when the address does not fit in a target ulong, so os_entry stays
uninitialised when a node has neither property.

ret was not tested after the fallback, so that uninitialised stack
value became opensbi_info.next_addr, the address OpenSBI jumps to when
it hands control to S-mode.

spl_opensbi_find_os_node() selects the first /fit-images subnode whose
os property matches the requested type and does not require an entry
or load property, so such a node is reachable.

Fail the boot instead, matching how the rest of the function handles a
device tree it cannot use.

Fixes: caa7fc2c5775 ("spl: Use standard FIT entries")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
 common/spl/spl_opensbi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index 0ed6afeacc..a3881f6597 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -97,6 +97,11 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 	ret = fit_image_get_entry(spl_image->fdt_addr, os_node, &os_entry);
 	if (ret)
 		ret = fit_image_get_load(spl_image->fdt_addr, os_node, &os_entry);
+	if (ret) {
+		pr_err("Can't get entry point or load address for %s, %d\n",
+		       genimg_get_os_name(os_type), ret);
+		hang();
+	}
 
 	/* Prepare opensbi_info object */
 	opensbi_info.magic = FW_DYNAMIC_INFO_MAGIC_VALUE;
-- 
2.43.0
