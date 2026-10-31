Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E53606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SCAc4loh;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Hig01un4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2AC180F1D;
	Sat, 31 Oct 2026 14:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8b6v01cf1kDc; Sat, 31 Oct 2026 14:11:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0594B80EA2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455919;
	b=k2DjOIPsywO128ouQ8Q3QiVRlkV0xRbLiEcNFMrDS3vgwFvDacAw0vTW6NJPq6fnkMnY
	 ipubAyfQBom4tyMMVeHHnPKeBqMV85Tz3WlUKocd9+0xpbqlDrayo9BToR77SJzHKZxWs
	 T/7Zv8uCr+6lrRuKzJDg+xt6po6wQNDNXyyAGrqVP2KMG1JJryttV1ROeEqjhAzbp9OaQ
	 hX4oouQMrEO+sErDo5IwER4KxOo3rBvaqS6Ma9ZTJw7jEeMTjYGqbdehvgVgIl3SIuVq5
	 2uBQCMRyZGhT1Gdeezd2kixJlik5FZ80u31QInd7Kh6SBK1+oNJJ6YyX86QXkskh92g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793455919;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=NOVJ+AF4DXrcGT0pDCfS/Ey+MRmrMAz09FbdXMCVie0=;
	b=dUhK6jaTfrkVMcX8ggZnEtRQYwrLP3MSSWim7Wj7tx4/RtirNe99atkSJ4y2CB5i7jpb
	 yioWh3r/G3bHzAkM1SjRTt9Br5oL+8sqwd5YgBXbG3WCpqu5KuyNBRMD4vTZj4EXKsATB
	 NvfptZempGf+wvqZOE9A1G0OJohR9hYgdclD08ekr9afuxO/VAUtreKwEp+6AclC+rX/+
	 fVNVNdGxoNWgDPBIUnmFj+VQDAYI50XyQRWjTND3okjL6HmA0eww1DK7tgjBuGeB+xT8t
	 zMGOP/q4nb2vJPDZRrh1rA371zvbKCStT7OUYpV5XO+TbKbSIUiKATO6zsfHOE4B2lA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793455919;
	bh=NOVJ+AF4DXrcGT0pDCfS/Ey+MRmrMAz09FbdXMCVie0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SCAc4lohpdgXcAKKRXHxgJKfSu9rbyUz+u7rzIVqlnFMq+b6lc4mtV3C7BfEaFCxT
	 IvNrwZfyLzbZGiEQh9tz2yD6D9oZycfJvmoodHYw/fHeZUP01kOmyNPq0LIkm48+Ku
	 G7fs9TO66RR08JvggPRmzIKGs+pZCy+7902CAM+LcXURC8xmRm+lAx/mOZXxG4biZp
	 fVqCTlMm/okhKG3FpCqhrWBBxUAXt830Z7CRQXQOs75/JyOnSC9HtSEyUg/pb3axJh
	 5GvzPpykenh7la28dhCT4kyq/uXtNDQq5wI2HSuG7u8ZAOObYg8amaNJfmZUAerV6g
	 fv5W5rebP+DIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0594B80EA2;
	Sat, 31 Oct 2026 14:11:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 287521DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 18E8740060
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:11:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6z_g34AJR6A8 for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 14:11:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 063BB40049
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793455916;
 b=GX0u7Zvx4QIRHDNe/BEfrj6GeUhJXVYzYNzhWeT7qyl1b+hYZePYq0GKYokhWkx1C+HA
 obAxozACdeI+p20sXRa91C+bOFvNpA05ES+xk1uP5QMqGfv1+hCHb4lXA+Fx/Glc5WwXN
 3vc6i7GyY8Aizx7OXUWxqZciojuopRjYu4Cfwi7K3cTsSQYszcPQt8OunWfm65oELC9sg
 8PHL6FO8D0nFVApNWGzF2eVHvxB4R6py3baGDxg3VyArnf9esqHAVq1zGxsKDUQNKf4m3
 WZKVMuVPkaWKnJKMYkzmQTXQoQ2uhg1W4l4v08AFzMP2It47uyU067cGsvew9PuUOvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793455916;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=NOVJ+AF4DXrcGT0pDCfS/Ey+MRmrMAz09FbdXMCVie0=;
 b=mPOiER1WAqFJE0gGhr8R5wkfjlZqJl4EPFir0606CtXtoA3glFJ3tE6CxTWSg/okr9nA
 SbVe12/OYN46pCe5S1vaABIt5VGbawg6aLXndsl+wkS3E3GH7JLD7yRSUh9ci3Yl7teMp
 YdfKGaSHcqvUjZyW9fv1rbhL7kfUPkyWMyoms+2TB0ahwo5hEKEPRP9bTYRNNIruygeAM
 I5gH9n3jLFJKwvSzyJHmvP/y3ODo/hSVL+3oNNhcOwmlP/U19DcZfZOMJkn79BYONz0D6
 b7tCFrdcIkuBPVzQRWGzk4uAYo3nsMUc2eBxt2ERZPRjT5q8Vh4Yx41R7K8ZAVlOg8A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Hig01un4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Hig01un4
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 063BB40049
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 14:11:55 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1a86c0316so2110793a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 07:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793455913; cv=none;
 d=google.com; s=arc-20260327;
 b=EdbMyK2eFVejZgAfHGsgmpbns8oYri9hfZS0zu3EZ3F629n/xNsdNdVHG/e+OfYnmG
 fbXdd6EdFlknvTeqgfHaOdYAqbqtqZKO2pnwgNi69VDPMsxtdOciVpIZdS8H0ohJV0hr
 QLAHAdv/kps/gn/47152u4hh5grZDCujRJZ/QgzSNzxgUt0oiPzz4LGs+VOSXdUQpM9o
 OczeE7EfJ1KnaAKFMBDfkT3DVYk6aInGQLap+ptM2HqPbRPFMMge6TJEmPQZW7kFZADE
 4kVAA4QmLdMGQP0leWd+Ux6Z9KDAL8ajuImomG9cuqMEmC9FzyXNvTdFTRCSnea49Pxe
 V8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=NOVJ+AF4DXrcGT0pDCfS/Ey+MRmrMAz09FbdXMCVie0=;
 fh=+KM1exMuVsSfOaKnT9pgrL6Dtn2dh0PFOsbu9B3jG40=;
 b=EpSNIgTqjNzNPR0exgDEb+fAIE0EXpve0t/6JQyuKwCxV/c9c44/dhqs1wnbotmzMv
 JYBwGBFmStnUi/woO+pRTcVy4U3/s9pb1SYQLY1Ay07qQ/g7w87NxS+Px6gSjcyn2S0R
 PUdBcS+lxlezjBhqugdFyRJ8ROVI14eQ5swyuW/6FlhBKQOsDVJP48Wq1MzI8BB6xQxJ
 lnI0IFvf1nMaTW9lDTCNTKy5sPwghzSWyrmrpcPJNQ4LiaUQln7s5ep3PLk4KgmmPs73
 G22kjcWBeD53ger61yVjOf7KPmaKl5sxUnXM2fQGsNQflYsHSYoH1XbXq7STKBucP4/E
 Io0A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793455913; x=1794060713;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NOVJ+AF4DXrcGT0pDCfS/Ey+MRmrMAz09FbdXMCVie0=;
 b=Hig01un48K5Nbxb4I6VNa2XFnkoUD5p8QAwC21KniUbPB204Jt93bqWyxs94uI+TAJ
 gojEC2kSLkHFEL8jyePy9F+2gM1yEJCfh6/Leq+pjv8XigXmcmMc7MSA4CZMNKlOnh5g
 21XQnHefiIZlLQtVthQ76sV/9dO4d49wQByXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793455913; x=1794060713;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NOVJ+AF4DXrcGT0pDCfS/Ey+MRmrMAz09FbdXMCVie0=;
 b=SSkcxO6v74ytEeoGcciLL0/vO795LWVOjOm+6pnKN0etDdHxRtBnWC3tjSz5KR6Z++
 efiLSRK3sp/CK+uFWF32KkYZ1lcdxHrBPeiHuMUxFdEWbZEWtAuoCxAUl82WwTeEGcSC
 m1aaHM81qAXYnommJPARezoPXHJZL6BPx1XI9EN7FhGAmbhijIMhh9xM29PlPp0xRnLl
 PF3qVhT/FH7rR4q567bulXt8RCo2aHzWZEec6DQALans3RLoPajeM5zrskcrlEiyNDSn
 5R7jIJF30IU8bydDHIUavE1lqWXOg5qnHZDXxvUuDYz9Gvg7HM5TLYb51HiJCW8mGL3R
 JrlA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTu7hMqCKYcyUNL9yzUxeBNz9dkc/bYekZYVrYb1CD8mzlsDCeElDW6iCJk+hsU25avjToK5g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLJPNUV+Er/o7RCL4ax0pJ5ns8mjaDkJbztIEW/fs8d1dJh5gj3
 dwz7SEk8yKNYuW4ZViUOxa7RMTT9+uXNH8op33/FacZy7Z1PYQryBlFJOLuDPOduaABtkayw6si
 K4ceph6yBeVJoFpNXpIZAkPC5Y+Cf2qPL/I7EEK5t
X-Gm-Gg: AYBFou0mr1xO42J3qRw3EMBx99uBa/cK2ZaxMK2wqJQTfOYEc4ib9mdS1q48WHqYhp3
 UCm89+cR/OfMkp9ulHpKmr67OPHzCO4CzjN6Sp9HlspN9MHplMcHXhKEl//r6xqTfdslNCF/8mm
 40i0oNzJQKAYqj21lVV7iBxyL/vq2umBGx8p+QvWQ68TITnllcRvORokuYmGONCuGOhJILFdFHq
 v/jLrXkeNeNr7O1grW6s8E/NHfeWrqm6Qlk5pPA2au65+YAvzGgDckLRLqRi1cMIuRYdHv2a9jz
 ZnPJkX8K/9Mk0hXjdk/GknJuckOrCJEyJlkHi/PhTH5KsYWZb0tuM01t9YDPPb6q20B29DwA4RG
 mR2QF080hQf9NYRSfb7qFGAblQohOqfplbsCRYfqtjOdZcdXoOes7hy+de0Tcr1tIKZGUn7JiUU
 /i5/MDzkf1ga92DKho
X-Received: by 2002:aa7:c0d7:0:b0:6b3:d0a0:39e5 with SMTP id
 4fb4d7f45d1cf-6b4d438bdb7mr2692206a12.9.1793455913620; Sat, 31 Oct 2026
 07:11:53 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:11:51 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 07:11:46 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029201348.730274-1-ekovsky@redhat.com>
References: <20261029201348.730274-1-ekovsky@redhat.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 07:11:51 -0700
X-Gm-Features: AclHuK9CcTPnIbWCdgV_06kFPMbe3td1YF5BtoMvQ_zshBieicca_Emf3Zt7NH4
Message-ID: <CAFLszTg9qSuGq9CHuQWBmGRqQVxT5yMbf267p+eNXNByFy61ng@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add support for OpenSSL Provider API
To: ekovsky@redhat.com
Cc: Tom Rini <trini@konsulko.com>, Tobias Olausson <tobias@eub.se>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Simon Glass <sjg@chromium.org>, 
 Jan Stancek <jstancek@redhat.com>, Enric Balletbo i Serra <eballetb@redhat.com>,
 a.fatoum@pengutronix.de, 
 mark.kettenis@xs4all.nl, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johannes Schneider <johannes.schneider@leica-geosystems.com>,
 u-boot@lists.u-boot-project.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bastian <bst@pengutronix.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Jaipaul Cheernam <jaipaul.cheernam@est.tech>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eddie,

On 2026-10-29T20:13:40+11:00, Eddie Kovsky <ekovsky@redhat.com> wrote:

> This series adds support for the OpenSSL Provider API while continuing
> to support the existing Engine API on distros shipping older releases of
> OpenSSL. Build dependencies for local development and CI are also
> updated, while the final patch adds support for using hardware tokens
> with the Provider API.

One thing I'd like to check before this series goes in. The provider
path does not accept the same command line as the engine path. -k must
be the full 'pkcs11:' URI, the key-name-hint is ignored and -N is
silently dropped (see my comments on patches 1 and 3). So the same
mkimage command works on one host and fails on another, depending on
the OpenSSL version. It would be worth keeping the existing command
line working with the provider if you can.

> The changes have been tested with the FIT signature verification vboot
> tests on Fedora 44, Debian 13, and RHEL 8 with OpenSSL 1.1.1. All 37
> tests pass with both the legacy Engine library installed and with the
> Provider API.

Just to check, none of the vboot tests use an engine or a pkcs11
token? If that's right, these 30-odd tests only cover the PEM-file
path, and nothing uses the pkcs11-provider package that the Dockerfile
change adds to CI. Since you already tested with SoftHSM, please can
you add a test which signs with a SoftHSM token? That would give the
CI package a purpose and would have caught the gap between patches 1
and 3.

Regards,
Simon
