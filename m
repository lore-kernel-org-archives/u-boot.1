Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D4A606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0ycy8xbX;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=eoFN0pkR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1F3B807F8;
	Tue,  3 Nov 2026 21:49:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6hNph0dAXPKz; Tue,  3 Nov 2026 21:49:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0A251808BD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793742556;
	b=svsgbCQQNChWcXchvQqp7aGD/0ZLsjKFi6qSMrOAKNflc41/NJn6oOKMRmuRTq3ht9Op
	 649v4D2e/XgdRzFv/Q3L2EsLB6GhEBTX1NCS0KQ+iULYDOBXaxVjPuTgupXeTAtKFvRfY
	 9Q2yuLl9yu24HIWoADXH1Liuc/gYSiiAGYq2hdwBYQQTzpau/D1R5fSTy19xuLN9/Kn+h
	 DAbFmUzKXRNNqcDXEXW1J5O699mof/xwniLD9otoUgrVkhDvutWqqDfwFmXYidiP0c0Eg
	 kRav9k+Q6KlEGCadOOOk4HUNgylu1yEqlX76XR7viOijK9wwZv42X4fCBcR6AMabuhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793742556;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gGKyO82k7Ok/AR/OFDLhec0xeK4j8HG/yoVriMGjH8s=;
	b=iu6VgpS2F1XuylrT1XiJfvUiDAEOPz1Mfbj2kUg+0yqbM445V+YHetrlaIw9F3mXxbSh
	 V14PGPfdKJejiGs4Ig7n2bKaMWbvL9VaxQNjRUqP3eNUjTN5/R0P9tTBgOU/HJ70VjtFo
	 +aE+d7b8UTJURxWqHkgvURX78tPhIfB3iC8zJCf1Lz0XFBw76m061J7ScNDW0lLgLW3Bw
	 mQ+EbY0sHzLH9mBUk/EjfhHcYp2/8Ifzof0coKNRnLEZ6B27aJNwUZ68+o2Y+IhiYCNMe
	 q3jTvKOCgdWMAyL581oLXR+J7CbX4NOcxS8qBtgmF8svZ3TrImwd0P7YY8ZdrbcWUpw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793742556;
	bh=gGKyO82k7Ok/AR/OFDLhec0xeK4j8HG/yoVriMGjH8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0ycy8xbXlUUHma3fbhd6Xi75NbXEKivYbpGYWy+EL/Geeaoro2L5IIp1Tvv6+9ZZ/
	 KUL5HKfCW0Y8Gv/6aTNCmCL3lkMOMq29CNX184wVdsulbPwhKKDdFOcIYTpVeTogJT
	 Pxxfg3STz69rSel9+BsqdVO3wLywJFthaKWCxOD5vASnkww411MRoM/ijnydwsyPDF
	 ff5EzWgbtP12YIh0vraWXT0pDoeusKVk4n+CIaipZeGftXutTmLu/s1T+2IDpZRjig
	 FATrB/o1zlcCXB6AEqSAKY6KMp+/F+uhR1yoZvvaPXsvXwVezofaU0H6yqdKvHCXKw
	 jqQY0UAptTJwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A251808BD;
	Tue,  3 Nov 2026 21:49:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ADA612B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9364A606A0
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:49:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2yTeRwJTVDa for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:49:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D3B49605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793742554;
 b=Hho3293qCkX0R6BLB7oV7/N3DgtxD8AKNqU2+bwMWN90gRuPgPxlrchPsVSvH/xYdZ10
 QKdyp+5n4iEi934lPTZeguPhW6uZJOwA/9TEuPaJiaL04C6aqz2DNTum7CO3nLzwoe9fC
 eU851UxxNgYQHZpKBbt5FoeCIs1dTKX2GwtP3GEAQCK/famuquC6hX5qmGHS7qU3+4IP7
 JTSdnArHf00UR6FZRpJdSnSbh3iHIRKiBeTOCBgN4XWX+4vrBPsxKtI/ljrrS52ZCvcgC
 hz7EdIqUnDsLiXVUDbjrVZPX4oyzSwFjrBaj4MsSAkvfLMGhuI4bJVwnrgUp/xA2zlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793742554;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=gGKyO82k7Ok/AR/OFDLhec0xeK4j8HG/yoVriMGjH8s=;
 b=GzBV8SawqitH5u6WQJn3oGUV+YzlvGZ/cahqekYsVMo6HCq803QDoXI33x7Rg6Px1S5h
 NjOdnDuGkusvm8fZF5rp1SCQdTZFXlhOkx9LUBeC6b87X7yjjGqOMlpj9y2hin4YjPJR7
 J1iWs2rIR95tScGsJtnglKhr+w/BNRDxoLOxeYE7JzdrfSwri1cpcD2FNKYRT+K3SlrBX
 xunaA7+DHriwYKp0CSfSMQXKtalfzBXcKywVndnzRCOsVKSHDtPHey1dmJHJRfs51/SZM
 onONlAaNhdGtVinUFQzhvg79mJrXmDQ/tpa0Cz/nwGfH+rQ+MqCJxLQvgwDmwLByfXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eoFN0pkR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32b; helo=mail-ot1-x32b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eoFN0pkR
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D3B49605DF
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:49:13 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-84e513874f8so40852a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793742552; x=1794347352;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gGKyO82k7Ok/AR/OFDLhec0xeK4j8HG/yoVriMGjH8s=;
 b=eoFN0pkRv7tURwKCVKcXHmnMCJiCr8GTpUFNiPPi58dFToI6U2Lwzuj2KwlvHtotBp
 BU38IUOOJOpwYkhqTlbRF6w6z+vfF+2dDHdz5n5friNM1uGw+zpQyJpU7Vnuexcz6OkE
 xSbP3CNcQYYHqgDrgv2EKIPrD/5fvk33gphoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793742552; x=1794347352;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gGKyO82k7Ok/AR/OFDLhec0xeK4j8HG/yoVriMGjH8s=;
 b=dKZUZI0aZsrENfvjeTqBvIboQORrMjZR/ls0XBj8Q91U6nDzPjisWaigK4tGMECILU
 rqc7QV/mI6xrhM0bILYRRn1vqtlM8I7OOsaIufhXPCzvxhSNYZDld/Yri48SgfGHr3m1
 wgKfcPU0mFP7vBMGLeXEeadhAw1wgzH8J58JpWc6kUsBLv9nxhgJu8DfF2qSSTjmoMsO
 FIj9PRl7Kczr563Lk+8wNeb6kw2eNZNX5gh1meh2tAXbgPUdoXpFAhT7tWeoLzkP4DFU
 mUzSTtmy/Gv+apXfM3Gk3ebkY10/nl+9rfX0KdO0io4Qi3R+ByW09IgF8WMZ4pOdKvyT
 TTaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBytsTu1DEkP0vPVZWkoVbgbEW949X0vKxeGVGGsUIBLgthRMOHhYa6lxG77aRZFSslkTdSKrXQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z89pDBXHX9ZbgGED3ibj9MV2c8q01bmi8qMrT53IJaTN/+RM2VG
 t/yusXLBxuSQJzLykXaBB45Gwx+yQJi/8OtTZbEg534KEL2u8shLK30i3kemd3MSBzI=
X-Gm-Gg: AYBFou0Elw5YQK7Uyv2vllvIqKWkJo1XrT4Q+vuozSD0ib7Yky1B2u3w6fXifWZlws2
 yKn/RjzkoB+xNWbdXBG4SCFU1BMO/pUqFdK3/x2MQwpOJaNbXZIq/osVepP5XpXuKfVJiGn+UmI
 yZ39Wm3phJD7DSPBtUN4ttmFNa9DHBA/g9TwM3VBZxZe6vI0aZC7Bt2Bo+5dcX2tDwjK43p3O+x
 BIhGz7P4Ntnv4rgsUq93bh7l8JyXeJTcDIU4o8826Y4tKLZh0jZ2EtBIX4aWasEjAp7cJRAzlsr
 1T8k3DY38fWI4S0khSFmhDkVonct6aQ/M0f+T5V9oDW9e6KK9f5oGqSwt5ztfPVr9Dr/TqiVf0m
 3+DXKAncvHAcnecq8I3Web3aLqZ2zl6oekShE7unTaKH/PH8YUyAKQryiYyxPeph9zgx69+53He
 qo7p11uvXDHTLKMeny1Mqm43Yl5UtztizHPwClhegjpjCTp8fNi30mPvzzV3ebLO+nVPaqgWekp
 /fqA4kLx2wo+82Tls0L07enoQgBWYZielvt9FJpjLf6sOcZIvUO0YWAcKk/SF+Cy5WR04gktgOp
 ma4joUOQB28ikySX1VhgtnwPK9RwEY8NpDLmkimmwhuIO7F4rHXTjefNFENuKRE3ETK28q5B6lk
 DTecb185Jh497nzSQKKWdCF72D+76jK7U9nGFrULPzcPtVNICseuqWv2iFFAfU+jmJseR3VFv5T
 5+WbXVDRHa9TawVIleDnyz7xFkybv3YQ==
X-Received: by 2002:a05:6808:bc2:b0:52d:10ca:d7ca with SMTP id
 5614622812f47-5640d973589mr12249956b6e.8.1793742552281; 
 Tue, 03 Nov 2026 13:49:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9f93e30sm42689b6e.13.2026.11.03.13.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:49:10 -0800 (PST)
Date: Tue, 3 Nov 2026 15:49:08 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 3/4] spl: optionally pass the bloblist to the next phase
 in registers
Message-ID: <20261103214908.GD785819@bill-the-cat>
References: <20261103-spl-bloblist-pass-regs-v1-0-bbbbb7e65fdd@baylibre.com>
 <20261103-spl-bloblist-pass-regs-v1-3-bbbbb7e65fdd@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+84ya9ykNPPZB6hV"
Content-Disposition: inline
In-Reply-To: <20261103-spl-bloblist-pass-regs-v1-3-bbbbb7e65fdd@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--+84ya9ykNPPZB6hV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 03:26:02PM -0600, David Lechner wrote:

> Add SPL_BLOBLIST_PASS_REGS to make the default jump_to_image() pass the
> bloblist to the next phase in registers, with the register conventions
> of the Firmware Handoff spec. Without it, or if there is no bloblist to
> pass, the next phase is started without arguments as before.
>=20
> U-Boot proper already looks for a bloblist in its boot registers, but
> SPL never puts one there, so the only way to hand the SPL bloblist on is
> a fixed address in memory that every phase has to agree on. Memory at a
> fixed address can also still hold a bloblist from an earlier boot, for
> example after a warm reset. Passing it in registers ties it to the
> current boot.
>=20
> Architectures and boards that provide their own jump_to_image() are not
> changed.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Thanks for doing this, it's been a missing feature for a bit. One
question. Why do we do the handoff in jump_to_image rather than
common/spl/spl.c::board_init_r() towards the end of the function, just
after we call bloblist_finish() ? I'm actually puzzled now since earlier
in the function we have:
        } else if (CONFIG_IS_ENABLED(ATF) && os =3D=3D IH_OS_ARM_TRUSTED_FI=
RMWARE) {
                debug("Jumping to U-Boot via ARM Trusted Firmware\n");
                spl_fixup_fdt(spl_image_fdt_addr(&spl_image));
                jumper =3D &spl_invoke_atf;

so we wouldn't be calling the default jump_to_image. Or did I miss
something?

--=20
Tom

--+84ya9ykNPPZB6hV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaupW0QAKCRAr4qD1Cr/k
CvHxAQDrQygHVTZYCq9BFIBZKPN9AfuPMsS0qbUUUgmFtG7kvAEA1ubjagyVpQdB
yrsEiIY66gPGhi4T3u8W3zJ8fcT6KAE=
=Cvzx
-----END PGP SIGNATURE-----

--+84ya9ykNPPZB6hV--
