Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9B606A325
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pop5ZRT9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EOEmW3Bu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 313EF80DC5;
	Tue, 20 Oct 2026 17:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xhm-fsfMdeFI; Tue, 20 Oct 2026 17:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C63680DD1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515908;
	b=IOrMJZWL94cKV4LJFuv+LZTicoyMmAnAb5cbXOUIX2iSpwVgK2rpvTOmMfI2FWUztX8i
	 XDyJneZZnaYSBJwCBCQ/bdjxh74j9Pqujm+7tE4JdG6mCMuxnqz1v6p1fowQz507/JcaT
	 FUdfDr3tsNtJDuQgi1WUsO3xfYgiF3/lohUCCCBqxAyIx9AXNDQJT27r67szLg5HnU7IC
	 orqmzM/v6419+GewDG8zIvXbmYJ6+TResKJeilQuZjvWhordUEJ42T4Q5DHmeUZVVIh4m
	 Cv1OxysqyOAeRQ9V7eNTfB7RLp3NsCHvmBz4j88OMT4+YRuRFU5JryoMXcPZoAmqSWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792515908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tZJchs5TF9pq0wNcnOhtpx07a+rPOXX4eSg3VugBuCo=;
	b=lXe3I26jXwEF1Ic/38AxVeCsAQVSC+LF8U61gQVmoz+hDUNYStnwjqqQdZPhbrgCmUwT
	 ZJXWlCSW0IoYFJW6SdpedfWckFBSqFK8RrDmLnfiRzezvZntz26aW+ZE0Yz4i35JY7gl7
	 yHptpm3Mp4umEbZzvW8KraNxavFgjW6cPpjjlTkfmqQq/oOpZWD3mTNLHsC8WkZ+NRVKD
	 7akP5emP9qZWKWp7IuCKpMLMGaew+xEaZ7Q6+TDu3xNgUqlD4tAbMhk0+OxkrxrQyE9oK
	 NwK68iCy+PGlQhiSiiUJM9ZD4FmWozqr+fkh4K5kKzBe3ycgPQfitkJUEP/faThTHTQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792515908;
	bh=tZJchs5TF9pq0wNcnOhtpx07a+rPOXX4eSg3VugBuCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pop5ZRT95k3GFcJrimWth4YkfPWFIfbvc+bkz6uZSe6UAQ1qeVdRdwhzurQJrD46Z
	 qHclAobRnh+un52GtSX1qOFk3owI5O8JuWeugfctSEC1hWQNRxH91BpT8J6/wY2nlW
	 oolmirX+3rJdrXkdCVrKoDRTTlJtSdxt5XM+jz2/cBDMivTJY5ZME2otonRiGHVzeE
	 3smIWs1c9xDpAB1TxdD6SHu0UWVBXg7C9vDXaHVI23B4vzyal8b8UC1Kk6hb9c7Hyd
	 6ASPD/qawDi9KxiQeCVTIHfwfTPbN0TQpwEXdJCrFqRsLJa3xkQZfl9StFqbzwUy/M
	 UGEK91zSh5Yxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C63680DD1;
	Tue, 20 Oct 2026 17:05:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 449381AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A30B400F3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hmbm6tJdWE8H for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2D1FA40060
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792515906;
 b=nsuX9KcpZnEybpMeU2CpM4Ox5oDuZi6PIIePSu5RpnEMiNIddSLRyzi71faJZpmIcU/Z
 wBORvKOmKUZd8YGp6QsJpK02v9/dnv+LF3p45CKjoAWMvrjdb2Es548X9H2cxSZ40q5mp
 GzhrHfzzCU8RY2fbC41TZ9tKC6jNzy/bmMT4Zw1FdiWGeBq673Xl6mOREieHRfM71gLsF
 ogFAXhosANflJZhBmU6tGsU1q1vwRCzUb+V5fgZINVvwN10Xz8XLvDTWfzrCJAf/IJ+O9
 iq8syql+/OqA+0kXYprwRYjcMWf5oFRfI88ScCM69T4iJaU+YdAyUXK7UY8j1kMseZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792515906;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=tZJchs5TF9pq0wNcnOhtpx07a+rPOXX4eSg3VugBuCo=;
 b=UKugAVcj8OgWPqD70FuJM95v/zyuYjcQyNrkDlKhfV13xD4LaMFT3Cb0UvBWFuRYfEGA
 Q3MmbGVy1rdHxdmdBhVy15+e+6oybz7rsZ578oOJCK8kUZXAZtxdZ3E1s2D83qfK0Sp7V
 49woyLViC2imkE8QOF42dMHqJIkSsxAoOqu77x/odztMq3QEIjHDNoooBmlIBbiHeS584
 8tpLfFaQlHPLwTQG+XjUmRRQKUbOVUR03JjfNh/WKWvINdyhYgNaWe9CCS3/TMnQqdvd5
 adguwyWmmrj0iutzyKkLRg8NEHOEOoJZBiyUnOn0pZvViB9oHGrotIi3QRg3c6oDTrw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EOEmW3Bu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::133; helo=mail-lf1-x133.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=EOEmW3Bu
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D1FA40060
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:05:04 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5ba3ac592faso3692873e87.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515901; cv=none;
 d=google.com; s=arc-20260327;
 b=RkArSsO889rDOhOBMVaX7o3Wxnp4c/TgvFoBC/RPrHmmX+D9byzvQJJhr7n242UaqT
 Of86h1sXaLe8cwwCARxwcF66GdsGolV5wUmUoW2wAlms6jqNhlIEH19GyfeHrnO1xH2j
 KZOFaTy9C5rC1fEDVajatGXo/MdMq5+zC5TZWVcfrmXxQsuepp+DoQ4wjA+rrVoXCJSy
 KyHeZR6J8KfpIUn/4a7EsU5WazxfSF9/eevG4+r9BRsMNfgis6pOyG7hzGeEk9qtyNrR
 OVOjQx/0jEhGaeWRQ0nYrNFESxVlM9drFK5qHWRMm0vbc03sWXLb6m+7IoqdQ3iPUXYv
 z6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tZJchs5TF9pq0wNcnOhtpx07a+rPOXX4eSg3VugBuCo=;
 fh=TZihwY44cajFnMc2Ou15FlNgDsDkwIzi8Opb6f0agvg=;
 b=aIPa+QIuAzY3Rguhi9RsCHYle0tKoaSU3WiNNAmhd5RXiJ12rkJ7rYsU0H/hhNcrpc
 V7XgOjBtW7Sao3ZQr2WLt+wSZvWPHa8p8O+PaxVpxf3BRgN97pSZfwqlc7YZU5kUTGAy
 v5eMtBJ7BBZOcUky5U2mziST/fterxofc9FzJAKfl/5vLgU577ru7Lh1DAx4wOuPSqIm
 GX76AG43YhTFVRZAf+R5vUjPJyFl57rKg/iw98VRDUC7FcgBm7C5fFzan3T9rcVrMzvg
 pAO/T4luJkFypgC5ZQ2c1BNXHu+TCSUreZPeLgMZtP6/PGBLqUnVvXbna9agxf3FNJGi
 1MhA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792515901; x=1793120701;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tZJchs5TF9pq0wNcnOhtpx07a+rPOXX4eSg3VugBuCo=;
 b=EOEmW3BuZKAk1vK3YmmXWQNZdsSYGIYQlUM1QfFM1r4XBwR2L78gkE6ZnF6Zo/ggQj
 5Sd2ydFsI71RC/SdFXt9etyPdrVE+Jq6SFct/s8qsjg+ATzxybSasgZXn7sLjRBOGoAT
 d2SfPV7Sqbk+QU9uYxxzgN3eHkqwkn37XvLptrgfekuFCm94vKRBMuoVtyYmR9P0rki4
 X7ShgRGsPZuz5RSp7VaTARrEwcou/h7JNnrhiGItv+svmaBAKHJJEzaEl4f/jie3itQ2
 SlmJH2CA67ZIptztB3tEnmdMwIxh8P/be5IsWgH2b3+t+Mco+kcryI6Bk0/vlXOR/IMk
 2f2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792515901; x=1793120701;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tZJchs5TF9pq0wNcnOhtpx07a+rPOXX4eSg3VugBuCo=;
 b=r4SxU41a4Z3SPHiSeGFDpKQm41FpBBL60LEkPxfN3c/9inul/gZnnOiws/lXLY97Uw
 CyOCkc6dK6qKtgy8EVwJwgsvquBIHV7WK7b51OS9+Zw5fIRlk5d1At0fJDGc/mugMLsf
 zn9YLlPv4X/DNgEZrzJQPZri7Ri33xfs81ncJLKZgVLRQcn9ITng77/iTWvk0yQkKj1m
 OECM/1iBtPY39NPVsgDyL8HPQkjF8n17FA+zq5pLc6Hy6xFGq2Np6bjNZ3QxAdqyzCpW
 t12sXzkxLwV5KFtAJvxkdrWlK4jOj9rWpFUgNHi/HIQOsM9L/PRLmLyHiKDcKVqjXEq0
 LUAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLv7/uInXzM84pozZ3kNZZZW0UD7YeemQ2pWthYWGvjzi+q8nVx6FfBs1UxCcFsXb6D8bVaxI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKknYaLQbiyMJt8oOBpUipRlW2XrwwIXw/Z7tdvU8oSSx6593BX
 2FS7i486cxSpsFdBvv8Rf5YCOHNXRRO/KaxuG3Oe2l84XU6u6Qf90Va98CtJ7zBVtyMScNtYrY/
 5tztsEQrWqAFqH0sKq+XMVnh86wboO08=
X-Gm-Gg: AYBFou2yZOJfIUv27u1pTtmFy0ArD+h6BbxU7RSsFCORFzZjAdO9x4VdCV2O/xeDKNK
 KIaWBprBJYQ8Q1KgcZiSbwdqN20uaIR7y2nQ9bALSnnHAYYDdN6YBgeaSXmT27qTqa5+TQ1PM4x
 7TfDq44Evjz5iBh5covGUxQX9TVnYeqREKmrriILmEUQNAuGtTiQ86wFtCM9qzIm9AMCSewMOee
 krMwR1kYxXsgh/3Q2hNAcI1TzJlhn3OZnaZUoZfIzVTxczkFMHD7o6L/fvJjIVcvMzKN/0gXMs8
 sEJlIoBRTXTmuvOdW8FVCMz+Nq/im+UYf7Un6JU+0AVJAhDpQtwcHepG8erk3E7NhUY0FIUYA4Y
 Xn+gcWm47dBzVzxfmZ6K9cTc7sjtQnGrXnlXu5xtKUoRmC5ueANhJIYs=
X-Received: by 2002:a05:6512:39c6:b0:5bc:dd4e:3a96 with SMTP id
 2adb3069b0e04-5be50a836fdmr3748018e87.65.1792515901494; Tue, 20 Oct 2026
 10:05:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020063714.694164-1-alexander.stein@ew.tq-group.com>
 <CAOMZO5AbCFF4vhZH==6n4Y_YGZ+tDU0OXzVx+3XpsjHb2_1Ofw@mail.gmail.com>
In-Reply-To: <CAOMZO5AbCFF4vhZH==6n4Y_YGZ+tDU0OXzVx+3XpsjHb2_1Ofw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 Oct 2026 14:04:46 -0300
X-Gm-Features: AclHuK8WzUR1ufBTffnB99_2EDrCEAGSuHi2ZB3H-zkdToCk6BEzjJWNDyaRG9k
Message-ID: <CAOMZO5BNNbQ_cmxOTXV2F=KMMNUY3k1bDEz61oe7Tck-dodxSA@mail.gmail.com>
Subject: Re: [PATCH 1/1] imx9: native: Add missing UART clocks
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 2:01=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> On Tue, Oct 20, 2026 at 3:37=E2=80=AFAM Alexander Stein
> <alexander.stein@ew.tq-group.com> wrote:
>
> > +
> > +       /* 24M */
>
> Please remove this line of comment. It is not helpful.

Also, please change the Subject from " imx9: native:" to "imx9: clock"
