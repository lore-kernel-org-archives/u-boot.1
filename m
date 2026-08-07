Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772CFC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 17:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A4B340797;
	Fri,  7 Aug 2026 17:34:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8uW6CzoVclQ6; Fri,  7 Aug 2026 17:34:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C35F40768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786124079;
	bh=iilitnHzik7ofnQRdmEG/kYCPpv99W7r+fdmUCsYihg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UEOrhCONSuoukEzSSVqDGU7FYUFFq9YMANqazlcYt9mibWIc4btzehOEQfEnVe4Wd
	 ovDu0anQ11+ZP8NYGNVat5loJnhFWfMbILoQR+dMlIbSUh7CjKObaRPcCZM+uLKOfq
	 hfMA+qURf3juuj6/jYpliuCwrWvj5NLmZQBdXfgTGq/Vq7t//kdZ1THf+z1Vb+pjlD
	 JX5xuMde6ESHVQjSbUEPUipEbxAnjlZKdSVi0Pp5DE9R2fo/zqseKnEwy4mN8ADYMw
	 rDGUaX/XCOZFhIKDn7SSMSNYo6pMnNI1kQCMdTwjAU3mIUSGq3b7P8TixLYj0E9D1W
	 R85t87xP2hBMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0C35F40768;
	Fri,  7 Aug 2026 17:34:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A98E1AF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 17:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3767A80D0B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 17:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RcTBEamYz9X for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 17:34:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 719FB80523
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 719FB80523
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 719FB80523
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 17:34:36 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7eb6573bd52so2582241a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 10:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786124075; x=1786728875;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iilitnHzik7ofnQRdmEG/kYCPpv99W7r+fdmUCsYihg=;
 b=IM7Qko5nea3yCAHzizS3G9SAoduog4PsugfN64LzKD9OqgYCK3sLyp0EpPaAityw9m
 oRZA/FKnFwgXsLsElj/dmAl2yvEgeUdMzyLKuZ+ELoBNUpQ3Aoefqx2y8leyn7HHDOSK
 dEouSIxVtT/LbjiLrWM/p6nOP5TQvndAk4PugIRs7C9jODrWyytPv7bfaMmvVyDr1Dot
 Nwibgwjy/CE1/J0v7cmF/iT68hp2SJf3su2IroggeLAEVTqWnbOVCNGtaEh+/ipjsP0s
 CSR4sUIxe9n+naXqpBXPfPwaphJBh4qYl7xXpcYNMZUdRd/PCGuLrDvV6l7VzPCBHNl4
 qzgg==
X-Gm-Message-State: AOJu0YyutUDBlV4xrs36kwjfP4KauAChfGi2b5xBfC2Ftpg0HRhcDeAB
 bdZBL2oRvM4PDorS7xtFCWWAQk3h6g3wquolPJdvoVLa57zBzMQXhQ7hCe7kuinYdF4=
X-Gm-Gg: AR+sD125waQv77nyC9dGVEqf8azQCR4eThurNYV4ODX497yaG2WPgY+XV8IDMcjNcv7
 XTRVER/FjTnDVDL+dCYUo0HSvLWJ6L2t9fSkKHvrX7M6lwBDtDDogeFXf5s3LiEFT4jLFke86zr
 QD3FMqrE2li3P+H+7fJW3ALxqmAIQdC64ON9dqKZZMrV2xmw/nU3pWUlI4ouUDqqLTYSeL+PzFM
 9eWWwT0qHqmt3oxk5gL+uOlUolzt/HRYkLG0pJcvVkeUJ3Rn8TlrOJSNfEUzEG7QsTWNKw9jM9T
 KfFO0kyklFwbOBM2fXJZstfsHjfAjQZfKHym6sw1s3qpHDrCq46YrnckscKu2plcr6yoAi2e9er
 baFc7aVkn46w51Aixvi3/4JsgNueJOT5vmdc7bWJXD1L8Wu5iBMnITNK6pXkAIlfhqsfUppXZqQ
 tRP7p0mVS1pfinSl9U+1wQQ4KBeXwHFhXoWneZFLhKFUnPjISNcoGD4WA3rVPv3AQWKtXyAy+c7
 ILiOueyFKvef4kqrZEOu4az1SL33UuHqwYT88m/uzfdTpCVLaZUX4eYuohrz+xSk/RKfCpD0XFy
 /N1mFOyzbQ==
X-Received: by 2002:a05:6830:2e01:b0:7e9:e8a6:6389 with SMTP id
 46e09a7af769-7f1e5c9713dmr15006362a34.4.1786124075365; 
 Fri, 07 Aug 2026 10:34:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b7c4c25sm1698328a34.22.2026.08.07.10.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 10:34:34 -0700 (PDT)
Date: Fri, 7 Aug 2026 11:34:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] toradex: select EVENT for TDX_CFG_BLOCK
Message-ID: <20260807173432.GA394392@bill-the-cat>
References: <20260807112545.1883789-1-mehmet.fide@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H3hJDzwJMBlGzPBQ"
Content-Disposition: inline
In-Reply-To: <20260807112545.1883789-1-mehmet.fide@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786124075; x=1786728875;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iilitnHzik7ofnQRdmEG/kYCPpv99W7r+fdmUCsYihg=;
 b=RRlli0NyLxXP3E/Yqx6qkIIp1JCupT67YFydQLawE8HUAN/yTFPM2GkSDOaM7f+YEM
 UiaDDeFoB4U7cGDYTysOwP2PaETZnf4rXzkUV8HiC8Y5c4dxFh+87sDemsKlkoZchXFk
 I+D0UR6qzUMhBAuW07Ou4JC6uo9DM2outEnkM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RRlli0Ny
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--H3hJDzwJMBlGzPBQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2026 at 01:25:45PM +0200, Mehmet Fide wrote:

> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
>=20
> The Toradex config block is read by settings_r(), which is reachable
> only as an event spy:
>=20
>   EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
>=20
> board_r.c does call INITCALL_EVT(EVT_SETTINGS_R) unconditionally, but
> with CONFIG_EVENT disabled event_notify_null() is an empty inline, so
> the spy is never reached and settings_r() never runs. Nothing else
> selects EVENT for colibri_vf, and CONFIG_EVENT has no prompt, so a
> defconfig cannot turn it on by itself.
>=20
> The effect is that serial#, ethaddr and eth1addr are never populated
> from the config block. serial# in turn is what fdt_root() copies into
> the device tree as "serial-number", so Linux loses
> /proc/device-tree/serial-number along with anything deriving a MAC
> address or a device identity from it. The failure is quiet: a module
> whose saved environment predates the conversion to the event framework
> keeps the old values and looks healthy until the environment is
> rewritten.
>=20
> Verified on a Colibri VF50. Before the change "printenv serial#"
> reports "not defined" and no "MISSING TORADEX CONFIG BLOCK" is
> printed, which is the signature of the spy never running. After it the
> banner shows
>=20
>   Model: Toradex 0013 Colibri VF50 128MB IT V1.2B
>   Serial#: 03135809
>=20
> and Linux finds /proc/device-tree/serial-number again.
>=20
> TDX_CFG_BLOCK cannot work without the spy, so select what it needs.
>=20
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>

Fixes: 118b17b84fc7 ("toradex: common: Use SETTINGS_R event to read toradex=
 config block")
Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--H3hJDzwJMBlGzPBQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCanYXJAAKCRAr4qD1Cr/k
CsDrAP4vEntNtqRjqJm/Z+PR4BK9IFFUUWCMiKyGXH5pXaHLXAEAh1C+uyFGrV3P
+yJOZDO3WNKs2O8TCUStrOdtgVhM9Q0=
=RM9Y
-----END PGP SIGNATURE-----

--H3hJDzwJMBlGzPBQ--
