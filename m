Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79DA606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QJV/n6L+;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=j9Cc/QBk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27CD880CA6;
	Mon, 26 Oct 2026 15:08:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ft26iQ5UpNNx; Mon, 26 Oct 2026 15:08:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3ED3B80C5D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793027335;
	b=XtEpWr8RGz3e6XGme0QslMRCAh9ZhdVaM5vpRGJweDOhkfiUZzH/H8s0dU0nNZz7e3Mh
	 YsrnFMsi9CmunAAlohGoin2MKJJ/UdBQPSEcqiinaROewBR3fCx95rbTUl5GEG0ruXD13
	 MstTfYqYy68nLeL7nZ+6hHrWJBiCFdwa2thxytLy6r7LpOha3pLgits0ijQR/JxYbD0j8
	 ZGzq98XDyVdPVQ0V8QPdpujOYBrc6LE2GpxCb20O9C2yL+c8tEC7/GcNQJgMv84PK2i++
	 QpzvOB3Rlj/sGzL9m+H0lI/nibOG3tJMsM5MJ1nDmjIq2qBpB/pMabBMD8ATg+blXhg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793027335;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oD/7rYJgnVIMePBN8Sov8P10BqB35LBKvqXVJg6jVb4=;
	b=QHkv0Rav45JCV4/QEsDjTzhezpnCV7Sa4A6z0msQjmKqPJEfh7XwURWHWqTOOETtIGeg
	 gknS7DzN1nprWtAde1dLTzyD8z3V7uL51CG/m2Q0vAAVfllKWomiMHP3+kdYnkGyTqiPg
	 SVIEfRWDJHEqdN/lBrti+hHKiXHxHILZTNJVXu2jA/sXbWN+qLEeuI+NgtF/vUnhUNS0t
	 IWK9HNQSxRuddh5iSV9gfww918sqGG1FGMT9Jyhkw4xVVR6Ix1xYvHjWui/U73/SnWuxg
	 0YXFlsYH7inI4HlO1TgV67hdK4bF3dRIM5apot/2EkydN9fuFe1og8Hx+MYWBRBpc6Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="j9Cc/QBk";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793027335;
	bh=oD/7rYJgnVIMePBN8Sov8P10BqB35LBKvqXVJg6jVb4=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QJV/n6L+cLR6W7h6cex/qmK5Cr2ggKYNuOryRfOdA2V6WoP1b8pRbyDk1ncCaPRYJ
	 qlRylSR9nwNl8U2ZDvwykzjzuG9T2FIMhu+AlCl0UhsdxspngdNLNM8DPJBVGCyioj
	 7M5lBztrbMuepJVoWEfYTL+o1aJKkD18FDQ4GbzrsWOMiPFf06erDOGedHUtUAPWHJ
	 PJjCuSqo9H3mXt8s7GFdz5RJrvdUTqUrnuhpwu6z93YB5BmwRpr6P9ubPb6lMnj6ne
	 K8hhY9m8rrgfYih5hTH0a4/W69bWopqgeDVxgVm3SRPRDQ/DXzytVSluGazsvrJ4if
	 isbuyDMGAcMJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ED3B80C5D;
	Mon, 26 Oct 2026 15:08:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 88A233A7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:08:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E4A980C5D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:08:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NdHMBTgasSiG for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3FAB880C26
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793027332;
 b=bBvU/fip7rFhRPjDg8NB69HsHJXR0Ek1nYFpPyn3aihifvdRJiU4IjQJfNDkrCV56bIW
 Kv48/oky1rZIrR5phncDplNbk6p7BxmbIWTu3ylSB+vzzjNfESYC3g/3yhuW2UOQJYfhN
 kyU9klIseerNddKapACc1XRCfkhzRC3PC0HLna0PEq2aZbNOq5awPoQYE/65YQxFmES+L
 zwQA03wNUZFZQVTLE4XwYLIHNbs4NbbWod0e3NCRmUgExW7KcFzGBaAryhyERy9aAF6Mx
 o496KMfM4OgCW+rfh3rVqu65U0XLYvWcvsEY614R2g7z1RT6rr+1aDzHe/1A20hO8Ww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793027332;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=oD/7rYJgnVIMePBN8Sov8P10BqB35LBKvqXVJg6jVb4=;
 b=ZHb3/14qPbG67XKSU2WI2wh4azCbKdvLRsrNMk0s/+KGPKKw5xiypWNFmL5W9m5fSu8/
 VA1vjxjXaafwFg+7DYdWoFbUK6eCZfWX9YbCqWdZ+zlmIpci6ekcyy6DCkStvvqFDEI5J
 C1A0YgoW7zJc5zyiem3JjCGCmPr4cDQ9Tghlwp92hpwyHamp2PX+oV9ySgUvgOS+gDvdv
 9l6JKxJavOyx3BTVu3SJZL0AYbSfg/ibEvjxxzNGbLVkHU4zyjVK2gx69bTRGmOX29bAI
 6eEkrg1kUvpfXnXDzSVDw3YjMLYFDLPwnhVrS0ly+fJBFTAest4zDFiNO2t89erOyOg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="j9Cc/QBk"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=j9Cc/QBk
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FAB880C26
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:08:51 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b2237b596cso4780615a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793027330; cv=none;
 d=google.com; s=arc-20260327;
 b=GDbBAGspQ0Gqyn81LgZs5zm9GPP1q6hXRprwjkWK+juwAQpN73BPUsQLs5K/S+Qv++
 9Sm6ebijUePJCBhMG+i44yglj1yc7cr8kmv1vpMe+9Mb8Oq7FXd0rMPBJWngKHf6ysMg
 B1zTVB1lsopEYqfbxnT4t+cA49aTw8XxRKDbxH3p8JtSN0r6PMaZ6o1635Dz/SRnx+Op
 IXs8+gcXPn897273ubOUoK8Mysy3fGydRaP+8ThrATR7MqVjGIas+EZiZN5P50JAPfze
 L+7y4CaosD/ZmUtjRLXdCJBU/61yUt7y27HecFCTB+9JW6AT41D4oE3/7fVMj9R0y3EN
 pa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=oD/7rYJgnVIMePBN8Sov8P10BqB35LBKvqXVJg6jVb4=;
 fh=o/2sd1ir5p3ShFbAq7ruUfS66BcBi55U1040hTVW30c=;
 b=GyVG+rpe7uERYvtaUSyUWFwiVGSK6xQAdVw/brQhJGJGVn6LbrlXIvrdY0K1CQObIi
 yTk5wwBMPUTeXKB0+BTm20cznqSGVt7yGWbolB8ZTYhv6KDRxoT+uxkc2ubzQoNc/ojB
 5WbHWVskSRLHpuD2mBzs7dPSNZq3Z4CD57oAoVb+tMvz/MlwO4Z8urGa6qaQxzOgMZCz
 wZeEiDaGP+36gjxlcnSBYEyYZ38PisR7h2vo6znaS6j35LrkcWk33uF+ijOTTdEmNGCu
 Z7Sx/Gg+LQPHEAL0D5x9ySWzwL9MoS1gxo7l7TVKHoX73v3MXjDv/tAGBPKPVQLLXoyB
 Adhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793027330; x=1793632130;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oD/7rYJgnVIMePBN8Sov8P10BqB35LBKvqXVJg6jVb4=;
 b=j9Cc/QBkCZvK86s4FqHDdh8CtwPkcMPZLknZtBy0zgVoQBar2O1HsTQ15GNr1RqoWM
 kpgQrEYvMOsuqZAh6JcfFcAuP4Yz/Mxh02+OuMktuMXDTvPzNx8QJuKxi08+DWBNlHCr
 J9ngR9wpfSP0rq6toR3zzaJ35XV+6CgwJeig0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793027330; x=1793632130;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oD/7rYJgnVIMePBN8Sov8P10BqB35LBKvqXVJg6jVb4=;
 b=pGXuTz0FjliTMzJFxP45xBQxHl0m46SFyL88a1VCy/Y5DPmNToXDrB9Vr08UEFe4iE
 4EnC6aC5BTcgmgv6t0LNhTqICOmJllwD+kOcLA+yB3ZiJ5dsF1sisAYIyYwDMkPCX5k+
 a4KvlmIEizfwSJMpqJz4mRUlmYk0UWm5THaDnYZdZUVa8a9z57/aSWPop8GatUBDF+5h
 LrsoRMza2xDQIhwy2qkcZKkDWd69g/A+15mVf7W+xjOy9ABoD9wVXItptmy00fx8g60l
 D6xv2jbdIXaz3zpaPi47gXhopuRf3ephNrppGECNZmpwC8PSK80q5UCQq0f+n9ExwZ9L
 LNHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwY9RBH1mwVWGtnuewjiywmSxKXBZlxSzqnUulvdx1Mbt8gKfmQgc1QYBO9lWD5KEaiowyGpdw=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJpSVOVlEsnCJFInLYzQ426NJ/6FGKcpteXr55mMGvTERuLNBTb
 SN4fmvLZ69pB/Fx3Un824RFv6DVkB35Q8A4JIEhzngR7vnErvy6kZefIBGUbnaiwep0zor/dLnq
 j9pPDSs1VKL/GpXwzP0msv9Y4Nq4MyUOIXakVhsqP
X-Gm-Gg: AYBFou2V5Kvbezsg7IPOJJL3+Cl7TeH+R5ct1/wFJJ4aX+zbTDLglVu25SzBINpL6sO
 CrR9JzB51FZ9MfLBBoRuHYATCo2zX+ycPm+GyyBUXVfBxzvppKWKtHqxhuvjZD0E51iNqVzhqgF
 xXj7RI8YuU73qcpVJpiodTNEmSUqb8T+OGecn7xAeg/Uw6ZxC3Wm5oZPKC8w2zf6xOm8+9CGmJc
 XMxacA7hDYvAre2DwLkkp/4oHb9buhzCW+FrZiaqjkxH0ReLg2n3cwbDiwVPHLf4/O4o7LRIkka
 NBkCbPLwUJ/p5cdSX2JABR5iNClZy7+s36xNSTIiQNC75uKLUGbVS0J4ebZpa886+dZl/HAbCIr
 QY7WS+EpTKP5rR039hucm3NLOk/RA3hhXX1M=
X-Received: by 2002:a05:6402:1ed1:b0:6ac:72dc:c3c5 with SMTP id
 4fb4d7f45d1cf-6b44300a8e8mr8400593a12.30.1793027329770; Mon, 26 Oct 2026
 08:08:49 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 08:08:48 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 26 Oct 2026 02:12:04 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261023190034.911023-9-ansuelsmth@gmail.com>
References: <20261023190034.911023-1-ansuelsmth@gmail.com>
 <20261023190034.911023-9-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 26 Oct 2026 08:08:48 -0700
X-Gm-Features: AclHuK8l4zQnRWUqA_tBmiBo1gl3Mj1wkcO0Mlo5hOUWVoVMIeDYwgbeuCZn8RM
Message-ID: <CAFLszTjh1+FGtL4sZLuKrXMvXds-GuG-JaOsZQnLEQ5a+K_05Q@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] test: dm: Add test for FW Loader feature
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Anshul Dalal <anshuld@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>, 
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Randolph Sapp <rs@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-23T19:00:21, Christian Marangi <ansuelsmth@gmail.com> wrote:
> test: dm: Add test for FW Loader feature
>
> Add basic test for FW Loader feature for the Filesystem way and FIP.
>
> Additional MMC testing image are added that loads a dummy firmware.bin in
> a fat partition or a simple FIP blob.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>
>  arch/sandbox/dts/test.dts          |  38 +++++++
>  configs/sandbox64_defconfig        |   2 +
>  configs/sandbox_defconfig          |   2 +
>  configs/sandbox_flattree_defconfig |   2 +
>  configs/sandbox_noinst_defconfig   |   1 +
>  configs/sandbox_spl_defconfig      |   2 +
>  configs/sandbox_vpl_defconfig      |   2 +
>  test/dm/Makefile                   |   1 +
>  test/dm/fw_loader.c                | 218 +++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py           |  58 ++++++++++
>  10 files changed, 326 insertions(+)

> diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
> @@ -21,6 +21,7 @@ CONFIG_SYS_MEMTEST_END=0x00101000
>  CONFIG_FIT=y
>  CONFIG_FIT_SIGNATURE=y
>  CONFIG_FIT_VERBOSE=y
> +CONFIG_FS_LOADER=y

sandbox_noinst already has CONFIG_FS_LOADER=y (next to
CONFIG_SPL_FS_LOADER), so this adds a duplicate. It also doesn't
enable CONFIG_FIP_LOADER. Since FW_LOADER_UCLASS is enabled,
test/dm/fw_loader.c is still built there, and sandbox_noinst runs
test.py in CI. So I expect the dm_test_fip_loader_* tests to fail on
that board, as nothing binds to the fip-loader node. Please can you
drop this line and add CONFIG_FIP_LOADER instead?

The new lines in the other defconfigs also look hand-placed:
savedefconfig would put them next to the other drivers/misc options
(as in noinst), not between WDT_* and FS_CBFS, or between BUTTON_CMD
and FIT. Please can you regenerate them with 'make savedefconfig'?

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,218 @@
> +static int dm_test_fw_loader_get_dev(struct unit_test_state *uts,
> +				     const char *name, struct udevice **dev)

This is a helper, not a test, so please drop the dm_test_ prefix. Also
please use 'devp' for the output parameter.

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,218 @@
> +	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
> +					buf, firmware_size, 0);
> +	ut_asserteq(firmware_size, ret);
> +
> +	ret = request_firmware_into_buf(fw_loader_dev, "firmware.bin",
> +					buf, firmware_size - 10, 10);
> +	ut_asserteq(firmware_size - 10, ret);

The FS test only checks the return value, not what is read. Please can
you check the buffer contents as the FIP test does, e.g. clear the
buffer and then check it against the 0xaa pattern? It would also help
to use a non-uniform pattern in the image, so that the offset read is
actually verified.

> diff --git a/test/dm/fw_loader.c b/test/dm/fw_loader.c
> @@ -0,0 +1,218 @@
> +	/* uuidgen -n @dns --md5 --name test = 45a113ac-c7f2-30b0-90a5-a399ab912716*/
> +	ret = request_firmware_size(fw_loader_dev,
> +				    "45a113ac-c7f2-30b0-90a5-a399ab912716");

This UUID string is repeated many times, so please put it in a #define
(with this comment) at the top. That also fixes the over-long comment
line.

> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> @@ -685,6 +686,61 @@ def test_ut_dm_init(ubman):
> +        # TOC Entry End Marker: Zero UUID + size set to size of entire FIP
> +        # Assume alignment as 1
> +        fh.write(uuid.UUID(int=0).bytes +
> +            struct.pack('<QQQ',
> +                fip_toc_header_size + 2 * fip_toc_entry_size + len(data),
> +                0, 0))

The comment says 'size', but this value goes into the offset field and
size is 0. That matches TF-A, so only the comment needs fixing.

Regards,
Simon
