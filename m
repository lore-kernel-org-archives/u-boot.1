Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B6FC44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:52:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EF1940500;
	Mon, 20 Jul 2026 18:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zkOwuUL3k6xH; Mon, 20 Jul 2026 18:52:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B4032404F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784573542;
	bh=olHhLn8deehWI5Kcbb3yfUAmkhMiEkKDmH9Ur8pVdI8=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=W0UVBFUmiuo+l7RPCuuC5fFQQgmcKFyKZsXzU05C2ZsY9+siFLLQZdQge6FbqkVBX
	 6fj4gL0pMhM8UB/v5gAsYjOn6NGDdkhkJ9rZlwHDMX2tDxAsK9jEyixdSa3g3K0IU6
	 celkwf5bRMy2iPDyf3oG4UlkhASS5L1hnkGFHoVnTXrn3go1Ewi0tylfI+01U1Czqu
	 qletfzFc8vxBQv71PkDExtmKtqZ38B9wy3vkaROQR80/l1ApouBK94IKrbsWCpm5IN
	 QG+1df39zqMS5sveqbhpfm8autm1kovqESRbudfbAzpjBVR5WMfM9Sk3syMDsKs3FQ
	 L6B2AmNFIdPhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4032404F4;
	Mon, 20 Jul 2026 18:52:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D536DDF0
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C6CBA40081
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:52:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ito5Rhms9ndL for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:52:21 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D6EF740086
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6EF740086
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6EF740086
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:52:20 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C31844F6; Mon, 20 Jul 2026 20:52:18 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 971A780433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:52:15 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so9479008a12.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784573535; cv=none;
 d=google.com; s=arc-20260327;
 b=qOdW3VV/igzre9QHq4LydXbX6TJDVfn4P0382c10sHxyPb1AWHKlcDmMkupbh3H5yi
 T1zMGVpp2bVVZygS5Tvhwr/VyCYHRMAzVXjZ0ad1cQ+qa3WDkkTUW9gV5fcG2Jrwzkxb
 qiV53exd1vxtW4VhK3bQcJpMpCmJYEsxVmcSah6n3CUPchmzpb9qVGeYbNAbEwj7vd9K
 KenmNu2v5phLsS8E+MfBmsLNpmvHDubBydcBwbe9YWm7s8PnmMHAlUhgFBw6lmzVEAkO
 9RybXzBxLsaVieYRk/49UlDxP1YFFdqjCO7xSBPiA2Q9UonRK5sxORubcwQO/fIlbBc3
 cJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=olHhLn8deehWI5Kcbb3yfUAmkhMiEkKDmH9Ur8pVdI8=;
 fh=cTeGPM65qL55ReajylhrL4dzXlA2lcgdGJ1Y61Sr+gY=;
 b=XHH5iBoyuZ6CYTmdBOxjRX/UDeRLvgS9Gxe2GMAlz/gTTPeNaRKVfHGI48/Oag00O9
 R+X5n2DqpmGv5L6n3JsPDKbOYZ+e0REZyWXDTgh/4zescnupD1Ho4v/BSdn1dQw7AKTp
 ZiB5hXFl8jxatFlQwHSpb0VaU6BpAWwf8hjlRhkiSL16hdETXM9tUjPt3VthVPfzpxf4
 6AKapgopunC2xGacynxbgRGwTVQ2mYSTjUjpss9tvggZDBWA2yRP0sMl/W8kgtvYMW9D
 9vEOhhFoLk9rIv39NdkdU+nrgi618yu3jO3GJjVkPENB1x29rpf0NtonrdR4fRbKeE8J
 w6eQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784573535; x=1785178335;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=olHhLn8deehWI5Kcbb3yfUAmkhMiEkKDmH9Ur8pVdI8=;
 b=BH+Gxi9fUd09mG6vsNoSn7iEYg49lIRju0XoKzaHW3bkCkwSx1GQNx5xzvIi+zAnFX
 rCCGWgx68sq46YpqTL6DahUHmm3wqVymvL3YlQn+gv1FHD5JuWAK3DzUnghk9NeXkNZP
 meKqZUSTdFd/nDy/KpVS8igMGVEhoL+qhF6vKK9wk1BnLNcIMb5JAAasnQs7lJ3S0PNn
 pMfqizvz5Yu6sVkiOyC2RmSnYASuRuuCKMe/HHb8b/FRvaqW3T8j0piFPJCEnz0l4CAm
 YbOUP76hFlBB6u1My6dhI+mUlrhJ5olbqxRRS5gPpmXPY1I8QUPmadoB3CC3H7vn67PD
 YGJw==
X-Gm-Message-State: AOJu0YzdHyekA78S3rniOSb9cIVOzOg6+OpmkBpgHyjAE+fZgMIJB1VX
 L64KyrOR9FNHeTkaiI0N4Ki4zfltRZL1zjECP7Y+ZjtEr2mflWV0kcEPE+typextMBOWVmfujV9
 +BRHjHvi+k9INEIqeJtGsk6SWkuVe9mRE4p4gh18F
X-Gm-Gg: AR+sD11h17L/jHnQkbh7YxmbY2B1MEoILj/SYP7yZR1et7qNXd7p3mNeZyXJ1p0JdFe
 2t85teu21AydUakPId+ZukdQzxw806uVPh1UFzAXdqiSJxXEHJnJ1dpZkfPM2D6BrvQTEANCN+4
 6Uht9lILqrN44oYGT7Pc+0OYqGyL55EwOGjNpraY8kEzGJnv/l7esWJUE71T8ZdTrLG5AGeswBg
 TZQ048GtxgsRorI12/t9hwUwOk66+e72m1ej6rhFmQRVKHKarvNwvGxIp/n
X-Received: by 2002:a05:6402:21cc:b0:698:6e7c:a975 with SMTP id
 4fb4d7f45d1cf-69e64e58551mr6376851a12.19.1784573535006; Mon, 20 Jul 2026
 11:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-typo-contribute-v1-1-90e89c6d648f@cherry.de>
In-Reply-To: <20260720-typo-contribute-v1-1-90e89c6d648f@cherry.de>
Date: Mon, 20 Jul 2026 12:52:02 -0600
X-Gm-Features: AUfX_mywUgfgK0FmfhzuuwkqZrcIUymWyHz-Vc9cCejCou49r6M2TrPo-3IFzfM
Message-ID: <CAFLszTgt=wLB2kRrhHhULV4PvEQkwREsF-6FQ9QnbDB9JsM+-Q@mail.gmail.com>
Subject: Re: [PATCH] doc: CONTRIBUTE: replace "as" with "like"
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784573535; x=1785178335; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=olHhLn8deehWI5Kcbb3yfUAmkhMiEkKDmH9Ur8pVdI8=;
 b=bo9eS+5kumav0feT7Aj6L0bmRxp1zgVvAtvmbxfcJxMn13OwjdzYtNRWOjaHq2UTh0
 4sfW1tL9DNK3aBKEqPFuEn+9QcaQGOi5w47hmLWPyg0IrtgEaFpuElD7c/HL1J1oslTc
 xyrfJYXYz+c2ZM0Slcv/MMSQf8TQZ5yz1eZFg=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=bo9eS+5k
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="bo9eS+5k";
 dkim-atps=neutral
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, 20 Jul 2026 at 02:49, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> It's either "as with" or "like" but not "as", as reported by Simon.
> Let's fix this oversight.
>
> Fixes: 06f014394594 ("doc: CONTRIBUTE: tell people reviewing *is* contributing")
> Reported-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>  doc/CONTRIBUTE.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
