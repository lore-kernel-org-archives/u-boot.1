Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F02EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1849F864DF;
	Wed, 23 Aug 2023 16:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HVbEllaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3E53864D2; Wed, 23 Aug 2023 16:42:18 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF013864D7
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d7485d37283so3888988276.1
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801733; x=1693406533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8dHmm8pUJ6w+C0GspRs6HYZ+p1ioji/1zQHycQnlvzk=;
 b=HVbEllaT7riBywIMNTAoASISmTaOAzXP+RUvQYqNUUcCw7Yrj7krGl+udqgSJ2e587
 GP3yPyoXUhQOp43BYMBzjCeCd2FTciQUHpFvsNVL1RN5kiIgLmkjZIYHkEFNgcOfUsG+
 x9Iuz8pV9T0mSCd5ED79sDkSAWkl89kyH+TX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801733; x=1693406533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dHmm8pUJ6w+C0GspRs6HYZ+p1ioji/1zQHycQnlvzk=;
 b=kvJLC7plgUCGCgnRofPb4JQPirS6DimMNnD8VBXz7wwihkeuc8aBTIidI7R8zdad1J
 yJBolSQBcgVxq3N6RlpLOU11FcevWM0X8D0MxtSRLTUpul8xsnkz9AmHtZreuRZ8QjyE
 Qhjpp5v+EnMRrPk/txeIVEpnlFzGyKWmcmFDzxRXKrmjJksj1Is+lXkf4F159tNvBo+B
 FEiJnBWdqU2Y/OUBgpPIF9FLXWssk6Fqaj6DSoUHqmMA+z6XB67nPUf9ohiZdkVthKH8
 puwtaDAkppVyGBBSoITzHPX+I+ZJha8JUvddYQBcG0g3jcuRn5YSggXPtPjeMmaPLPbZ
 GUJg==
X-Gm-Message-State: AOJu0YzLlj2n43uTX0s3BFhitCO7IkY2zTxPo2s62VmophNP+AB76azn
 VH8H4f/ATzCIFDujBoxBsVvxgg==
X-Google-Smtp-Source: AGHT+IFfaTMJO2YL66B4pRsbPCKkx9OzTwAj3sgPrMSybj/vdC2ErTWTH1krgV7x1jIfZl+4aRv39Q==
X-Received: by 2002:a05:6902:290:b0:d74:5f4c:823 with SMTP id
 v16-20020a056902029000b00d745f4c0823mr12675364ybh.16.1692801733127; 
 Wed, 23 Aug 2023 07:42:13 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a259111000000b00d74b8fa3497sm1475141ybl.20.2023.08.23.07.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:12 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 3/8] disk: Simplify disk_blk_{write, erase}() using
 blk_{write, erase}()
Message-ID: <20230823144210.GU3953269@bill-the-cat>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-3-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZXFOVtcMmaHua7s7"
Content-Disposition: inline
In-Reply-To: <20230813234648.591083-3-marek.vasut+renesas@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


--ZXFOVtcMmaHua7s7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:46:43AM +0200, Marek Vasut wrote:

> These two functions are basically identical, just call the blk_*()
> functions from disk_blk_*() functions. The only difference is that
> the disk_blk_*() functions have to use parent block device as the
> udevice implementing block device operations.
>=20
> Add documentation on what those functions really do. The documentation
> is not wrong even though it likely does look that way. The write/erase
> functions really do not take into account the partition offset. This
> will be fixed in the next patch.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--ZXFOVtcMmaHua7s7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGsIACgkQFHw5/5Y0
tyxglAv+IZ3r4MLijHErhvzNkrXQRqoy5Hp8U8WfbRh/j5NlZIf+GxzMeFJxiToW
5DQ5dubQNnXdaxJOTNBl9VC9ioa11plXSyRNVFJywqkx/edBQlQnehDx515UVn5M
P9HGwsU5TCyZ8EDRyrQ7b7UMpKkrlBt84Me3C07YjgBEpG74LAI2+kJBji1ArZMh
rkaiV0tXgsONvpGLyskQF+/LivkGGohW3QcEHm7k5DIVnm1j1HRzFzUGKsgLskuG
BWNVMwkuyA/rJULU3mNXZmfJHng8liWbFh0U+rPc83t9AR30lBzsrxJQtaZk6qxn
JPOq63ZYi3gTo72MZGRR0K7oo1rgooSe5krP39kZV0wMMplAh9DUpbcbqYlFTLgh
m38FZcp9DlKsSytp53hsR054wJRoO2KdrmB/+wQ9lllP+lXc8/cLKPO7QT05w1rv
K3AuBAcpABOg+EQIQ+d5CHv/YWIJ0NKPvA8FKpKciFRGv/E3DGWy1odWx8fQ9XRh
5o7QyoxU
=wJfK
-----END PGP SIGNATURE-----

--ZXFOVtcMmaHua7s7--
