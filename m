Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D349CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 836F380AF5;
	Mon, 12 Oct 2026 21:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GERY7hWZ_LBV; Mon, 12 Oct 2026 21:50:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D9C2A80931
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791841817;
	b=AJk28t9bFbMHT9CPszg6rqmwo3WLBW8AihH0d1iZqUw+Tygcl0ThYRj8s1wBY0qwRpdZ
	 ZZ1Uy7j+QtU91yDe0MIStUIUjiqrv8v5RnsGdwH3+vW8ndoBWOwpZe6fQEWkRinHUeG4Z
	 oqj4CNCmOhLOIxFv9316YW8nfMui2KydyVQgfyX0NOcwxgHY+KU++iYxWyL9ZXGl9idoi
	 Nj6VxeqgoeUJlGqvEOf0yscIKSn6vivh8t6YplxIFa/uhYoT7mOTIdY14BOBAi44t1LKf
	 9Yj8KIMGtuKkN4KOPaYcVoF0vRTSiOmdvIfSyLlXce60zvFGkhsA1JqqgvjbjJHDgiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791841817;
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
	b=MsN/jWV0KzTqp1Z8hcDyB2B/UqkTdAtuuebWhy0ZNKaa4nNsXUVysAEiNBaTvvZkIyhc
	 5rPbVinjbZDGQnZF5R9UgpK9w9p3rGWFD4mtpeRRzZmTXCiTIgg/roMvS2s6kBCgvvGz5
	 0YI5bu3H8Er3HlHagmL++cFRAKuJ6UKPJS+x/S/JyYGbCPkNv0zIGgcw39vDvL0CD6z0z
	 NbZHvzX/we1pZmC/cror/jl7lQZ/Nvk6XdSLZPAwZBrOAnJn4a6YXE3Yr21iv+utPI1di
	 b53COc7mfdG/1txGkw6RVdIS51iWUbak7z0SLo9inf4oGhDjMZu8YqTrrOpi3Yq0uFQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791841817;
	bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j/v4MqYR/hfrA9dugfF2P1ZUa/47rBOwTrXnU5ID9tQeOQnUtds6mg4Ev7jyga12k
	 R/BWmxLTcJByjsJ+BTTjKfPEatrjT4QMUOG2Ncq58/JgRV9R4Rs6roMyytQD4c9dRg
	 pdip5W9DR3l2l0n8xte6X3py0BkGkUM9KI0T1/VxeWJMM4hBeqhyE+S/lFT9r9vO1b
	 IIiOcTbSyFDJ2eN1U1grlnFfOjuNRUJwxeaR00hLlUHb3xX0GDfiGLrXTDhcwagmbj
	 jpNG8hUWURazrmuGlxndkIXpR3o5vy+yE6BPxN0PK70hG8JJc9metHbSsdo9majkWa
	 A2kQW0gXfFkvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9C2A80931;
	Mon, 12 Oct 2026 21:50:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BDEE4DD
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61ADC404E9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 13Umgq2ey_c5 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:46:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A5835404EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791841577;
 b=Hove9JpfpqPDN1UW84PoNTbBYGbYQ1DULh3nauQlbsXHT9Zt8OeCf9tNRqYiKk0xG/aT
 vOYZrgZdQgxKNSLosSkfDcvpgM6TqrWCJHgnEg3nl4xxccx7j0jvcqkBORHoBmCHY4q+q
 50JShveIpRBaoEfNX6quGHjYIt8fKduJbCNP4AigeUfojoraRW0DhOy8qrOm35mfuM9mb
 qvWurCbGqaRDlxQy87936AdfOfMeQPZx0fiacnzIHJEFw38A2pRuOTAXU0XDZIbT7o702
 9b+VrHSjWyO2RFA0yDfRCH1h8cGsZ/6ZW0vLlX8CSW1eFBAjSpq70R+Jub7wXQ8YPrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791841577;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
 b=lVJLLsqfl5Ia1/akt1EPBoelJakLLlTCPCUqACJ4KqvY6X7BWYCEcLt3qApVHP8oyvaZ
 M65ierUwqhn7a3T1Xe3B/ymWKZ+kX4Z9ElJEkN1CZq7m1CRIa6sKqMmrtGTjKouxVbk28
 RhdQgrGoxZRl/aVPOADfamvqnZ9us9WBbf9dexf4SiODi96H2maH3MQB6ymQYhDZSZDeV
 b+E7Rh01f9JXiEY7MV9/fkkOi9cgV5PY8sMpc+Xhxk7jkWt/JiUaKH4pqrK7f/rzvUN7H
 von2MWTQd96ltXHZwDjWOXfmITLrP1eFgqzmcrT0KnItaRq01wawbLreXgzFLug2Ptw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EYoEBiH8; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::92a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92a; helo=mail-ua1-x92a.google.com;
 envelope-from=sebasjosue84@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EYoEBiH8
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5835404EB
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:46:17 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-988bb309c2bso1173630241.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791841576; x=1792446376;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
 b=EYoEBiH8ShNHnT3hew8xy1eQ0V5ufw+vt5Ox3B11kFHLNYKtV01gtPqT5Uzzpj7s2w
 nmE/xtppQ3jc0M9pzjI7o5RZ/Q4CIFOEj+Y8Gd3peA/2e0CT+XHHvZEdLxV0mIkh7l7l
 loIL+hRymQatj+46XfLS6if89IrN0zmGYofJojWVe5vb825y3qkRDHLeaOLpjYrupgmI
 7QxRT6LqthZrxCyU0srEAaUHaZifuCuFXdUER6nk3tl5ehBznuyZCcNOJs3hnGJM+nNZ
 wMB2qBoBkbIfw5aVKmmvcPLXKzspcMRH1HZPXnztmfKk63AIQciz8dNjC9sADdD5d2xW
 CfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841576; x=1792446376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U/fUjzhMsoBtKrAAl7dv/cnOqByvsUj9kMF2o2LL9xI=;
 b=xIVeGeShlTUB9Ox1dtd3d4ISZ+IzrzUfeVhcww54W4STj7HZqqhUlptYwsgv16jL9n
 v4VxegIm2DHmKnoIe9PY7GZ2FJV14zdn3NorabBsBdIJgqd5xojiRRQtrB5F3rQo33dr
 xc9Etnoa56oqVze5upf1q7ePIbI3cP65gXmu7tPD0/Jcf9yYMul7cjQ0T1RPjkR45dLN
 a9Pb7+ZZHvG/kV6UwD1ogj7+g5Wy29OTYefv0mkpZ+11xSKJJ1kSpEpcIRd5lxIRrdj6
 AGZeL2QJet4ERnzBsscySX1KwOyPLOmejAqNTK/p5/Q3Z3A7H/84sSaUomKhtbRo0S6r
 nNgw==
X-Gm-Message-State: AFq9FYJSZ5WkJyHBXvBYr3UpW7JcLn7Jnugl+gNV22bc2PONMu3nlNaa
 FTmcQ/42EQLXecUeC7NgowxeB/J6dBgcHl9WcWfCVzU5kjiZTCB9hMdUxy11ZZlv9vpR/w==
X-Gm-Gg: AYBFou2iDvSfcYFrojNbjYXXlFSbviTvhrBJyVfHE5pCgJUHvv9fCkF1tpZdjH4l3NH
 ZgtB4zo67Pd19tn4oN123RADHfsoQMEKEN7+Lbu76K3gEO7qhvJUZs1drC1JBrCMYrfzHqB1ACF
 3TyCp9aLPP2ITppH5wuKRqzKEUD1MIH61KVIYC3WMz5+TJzfbJmAxcToaW42lMNry/UJZPFoSVk
 xr1ArMoHB6V9We44CDQXQE6dk279ftbwZ2lKIfusKWAYiWSi5Gnoqy4vcXDu5VTRSv2hcmMYQGK
 WevD9uZ+lY2C1VIrubZt4wHfesCsofYaXQtpyX2FR31UZ6t5Xf5VaHD12Lb5vso+u9RKO7Mw+dG
 N1oVENk1ShqishescQ6A/L8e9GpXpVTOkPatHhHggV2dHHd7w8Ja3NsaPYzQGYoKlCUJPI182Rj
 3YEryseiGnm/VI3LgHE4ZXbhLCcSQUYSCgy7QOrn9jzZdIiVx/iTG+pKvv8+XJ7/UZHq3PyP/+e
 MRumwFVmPOwKhg+H9dH7u4SM6dAvnSNMjFedTuYcVAp+2n402v2BAOxBQcb2Wc=
X-Received: by 2002:a05:6102:390d:b0:7c3:fcb:180c with SMTP id
 ada2fe7eead31-7cb37343313mr3308418137.20.1791841575904; 
 Mon, 12 Oct 2026 14:46:15 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cb35471536sm7301225137.11.2026.10.12.14.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:46:15 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, sjg@chromium.org, michal.simek@amd.com,
 Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v2 2/2] spl: opensbi: Check the return of the entry/load lookup
Date: Mon, 12 Oct 2026 15:46:04 -0600
Message-ID: <20261012214604.1477684-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012214604.1477684-1-sebasjosue84@gmail.com>
References: <20261012214604.1477684-1-sebasjosue84@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 21:50:12 +0000
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

