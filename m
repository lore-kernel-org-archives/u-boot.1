Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C846606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RI7ngz0X;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=k8hBifeS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24F1180DD8;
	Tue,  3 Nov 2026 20:22:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e5piuY_bHcPU; Tue,  3 Nov 2026 20:22:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C5AF80D44
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793737346;
	b=TkQ8D0MmYmWk2YRabmfniM/ngN/3I2v23DgYLZSMFIu0IqEEtGbkhcZNhzdiJdxhxG+n
	 6IN6rPo8Uh2RoX1xugsFkg59q5r+xXeaDa/6Yo54mPg7jEiZn/d05NvSwO9NbhLGhYs/D
	 +FHg5Xna+1npwcN8GgtvuwpfLHVmJmYevD1rH2o8PKKYFWvR/o4EPpaoxTPjbZ01bXjJi
	 9rtDNuTV7R2iICPcfFV9O1bPboMBbDiokYiepZ0z6exQIm5LV5dwG0x0IHufsWqeJC+Ed
	 z9Oq9OfPmc4H0GsAp1TBO5/mrTGO3nIblnhdihUkkHVBlJdErsnY9E0P9DeupSndK5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793737346;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ic2o9jUzHm5nOYsLMhQAdm/CFClpCVwfduYZuToP99A=;
	b=KLuuJB8IQm1Axth49PezNb4NWZ6KRLawUzg31Xi8nT/MiS6W3KisT6Kur+N49rVA0gIR
	 lyRfXDYlC3McbnD+8C3L+vjxaBTiZX6J3tEWaA1lcgUsSG7Bqcl6AdHQ3p3KGhsjXIszS
	 zfQp0FXis6NnnTFqnJXGckC9eC/P6FYWs9lFJD9TucVHzx0selJmw25VxuwRYNesl+tB2
	 W0AaJGOrwHfH5JxMcOQyCpWw17pRIvPrt7YBMc4GMQ2YzMoFvIyHTw7idGMMYMe6jEYc7
	 TOja7j1/RbIF3bKZk2FNr39aTHCVvMLxoXWT68HHPeEIdrHi1v8d3FJnknwRLqg1atw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=k8hBifeS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793737346;
	bh=ic2o9jUzHm5nOYsLMhQAdm/CFClpCVwfduYZuToP99A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RI7ngz0XNDFwc3ghTFUyYnaJuptZQnNSGovZeUk+6k6gUX7hweF91PcyXJE9kUp6O
	 hWw9BPCIyo2+99r9jNxI1XN1Y6rYJNZ5vNTWCIE6rZrFcTXYdpbDwj3kaJBSC2JwP/
	 ybNgj0EowqtTa4rvSL0tB2/o/gthMA4kva1wyM7WsCOIZBZpFqH8sLe7OrHyHE/lf0
	 NAPYVxXlefKiX8TQrwKZr10ksRdsQleNPPmfPrmpq3/MBnn+g1ksvGNEnEM3kwsB1h
	 a97i1qySSh0rz+QP5c9gDKuU4L9Avv2OQ7tkL6Z5PVQ1mMkauZRBiOrW2PkAVhVi5O
	 Fva6woINiIKWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C5AF80D44;
	Tue,  3 Nov 2026 20:22:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 146FC235
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 20:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1197E80D44
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 20:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRHNk_plk1xW for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 20:22:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3D45080934
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793737344;
 b=ZRMbzpJvSFol1ICrPAccAMz7BB2Vw0ECuiUn0Z3jmLBy3QtH7VPExSDhnY5/OU2hw0LW
 kKkXRqQwTx+yfZSfqe8HMi42zg6KlLe/8IPCeNK2zTYu7o0xes8W0jMZqkCngZ3ji+aWF
 RU/LqBEe1eD1MyZ32lnKxBbezQ9DzU++X50NdcxZqe9SHQ8pShVpgAnUHsDJPXDWPRJav
 6/CUX9KBrNA9cpzPX/nD6ZdnOs4YHCGpzoqz3zYG2CHpwNtxZz4o3/ygI9mMDsJUCFjWB
 9vCW8Dl0paeQ7PDQzAj0fMkf/liL2JILWxIhCzmewZVey6PzRryIt7ZWgzpq7+tHr5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793737344;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=ic2o9jUzHm5nOYsLMhQAdm/CFClpCVwfduYZuToP99A=;
 b=r03w8sDoBjVD1qZ7eAN0IZXFl3M9BOSr3YqP+2J5b/S/E3PavHXdEUTwk2iNhL7Pp2tR
 vyM7FSQ9akEbApzYVQnZGFeob2RioexrY8vwPPA/LEyPPbVc+YxF024YszjBobQ70pTDh
 zR2ZLsPe5cNBdnfNWKVvHDAO7RGH41J4AQc4lkAHLs0lcQGExopVn2GjjSCoRsRt+Y6se
 L+D6OOyRHkVarWOuOckfTnlLzW4UfTcYdBZwpOpHHMbN2tVotHxw/w+4JA6D4EFpHi+fx
 GQMPpET8I2gZOi48ub8+RbnaDLJxmdgduxHKD6x5IUctgGQ8RB3K4Q/ET5KqymIYnuQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=k8hBifeS; 
 arc=none smtp.remote-ip="2001:4860:4864:20::33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=k8hBifeS
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D45080934
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 20:22:23 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4a6bb779d13so32745fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793737343; x=1794342143;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ic2o9jUzHm5nOYsLMhQAdm/CFClpCVwfduYZuToP99A=;
 b=k8hBifeSaSflR05fxJB9Yv1VU6Jj4cPj/wnybPQvYPl7OYLnBmTLbPASPwkcPE5U1D
 VrZJ52R2goPXJ0BPaaxG0XrS+Z7mtw2znGnhn3v4/Pj7ymJdGJGCH4Di2SstiwRgc0a6
 MDEsLS8RNFYSENuFyIvdWFCukX9Jt7XKXArmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793737343; x=1794342143;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ic2o9jUzHm5nOYsLMhQAdm/CFClpCVwfduYZuToP99A=;
 b=E46QFc2RwQ6rCiV5pkDovo8l5kWgIK1243l0uiWPCxATWUPxc0xoq4V6GY1PITZBgM
 PE2p7EIQVSgOXQX0ZoKzrj+0tHsFKPPE2Oq09Kg2PZxtnWnEUVuVQQ7zQ0xgnTcnWTl0
 mzFq6yvKwsWHkrYaaepEBYbLtgrMQLhoZ87h0qMFH65xARrN7iPDpjnnV80RJJWQb0ee
 QUhvdtvZon4fbjKqPonNdTrakDMVbuqhaO/j3UjtnPLGRLE/vcD8GP1bT3KaZ49DEUh9
 qfYYgT/IWNZYdBLmroKeQAwiYY2HplKKHgEolDHDCttS/1P4CO+aEts7MMmrnMKqNG4i
 TOYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPq96xUwy4mtK+ZGrxHXjwNbB6hvLWztV90Y5og7UcTRQ9xqgjU2IoNSG5JLMB8QlwXbycYiQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/azyBfKssNCIDSZ47dnR2WoEQ+BbKs647q0FYRSsBmTJLcrZhu
 FwckvI7OF0SP+hQhNGvcfILN+EErs/9pDjkCqKr48i7Xm6W/Na4EQaATKySMoAXO/s0=
X-Gm-Gg: AYBFou2BZxsgMZGmpqa3Hxq2OUPWCqOO6QOiPnvBq5VGtzIMC/8QbZaJp0/NWHfvHK2
 EnkIZTK1xxDk1cJ9Doy3/gBK3bj9s40aEbYa20Nk0Z1XiO4rkK+GGRzyz53mcFRNtlqIHWuW7s1
 7rzUODdhhEld0aHIIWNYhxNfLNeFT2eikzw2uhsYTKrqs3OKrCWsagYAP88OCLO4u/QewfKgP+8
 kQowM8FVLfrhtwg48ioUg5jqlBd3rBK2MJ20+LZ80IinC/LgceVvw37R0U+BNG99NUt7gCYArdX
 TF11EfJLDLAMObnsoUZnfWmn4pPx5bdGcFzrOQQEXOsGT2XWi/+zjkr2l8RbtX6xJ7bOYMJAOzp
 v2nLM0sQ5orhp+rVk2HAhQ6UTptZK4f7GgwwaJpnbZ5+jyXOQFY2H0Bfo3tE0eqTMd/ZsRMwgFQ
 OPnNTyXwJgJWLMAk7NCBJXD0EcAOLp5tZX231Z2SAhaok1rufAOsgBHiX8hlQ62Gw/DqEDz4D6a
 2J1P+JEEWwOWRWXnpx8cqg4e0ueWnOASjCBfZLOZxF7XPiYmv4+meURIsk+DgTnQ5TvpL3T2YJ/
 C9zwKWBfX6BQlOl11amQpycZ6QiAXHagAnn+UgDaHBADQV+Gvqn0q3UdS+xuFKVEZ3Sw3EEXypF
 B//AvQlM+cJta0a/83Jf93tHtNGwu/y0brogQ2DbhVyQmdEUBIo8h3fLDxHzvct5qxjiaPZ2k//
 OxGyH+piXC5WWl6k8ikh/BCyMS9dT+CA==
X-Received: by 2002:a05:6871:e410:b0:494:b0db:4e0d with SMTP id
 586e51a60fabf-4a9072d4488mr9308519fac.7.1793737342772; 
 Tue, 03 Nov 2026 12:22:22 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4acea680cacsm23494fac.16.2026.11.03.12.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:22:21 -0800 (PST)
Date: Tue, 3 Nov 2026 14:22:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] dm: core: Unlink the device when bind fails without
 DM_DEVICE_REMOVE
Message-ID: <20261103202219.GB785819@bill-the-cat>
References: <20261026030925.1002846-1-oss.patchbox@gmail.com>
 <20261103193614.1250525-1-oss.patchbox@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HPN+XJgnqYl65Xaq"
Content-Disposition: inline
In-Reply-To: <20261103193614.1250525-1-oss.patchbox@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--HPN+XJgnqYl65Xaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 02:36:06PM -0500, Yuho Choi wrote:

> device_bind_common() adds the new device to its parent's list of
> children and to its uclass before it calls the bind methods. If one of
> them fails, the error path takes the device off both lists again, but
> only when DM_DEVICE_REMOVE is enabled. The free(dev) at the end of the
> error path is unconditional, so without DM_DEVICE_REMOVE the freed
> device stays on both lists.
>=20
> DM_DEVICE_REMOVE is disabled by default in SPL, and a failing bind is
> not unusual there: lists_bind_fdt() takes -ENODEV from a bind method as
> the driver refusing the node and goes on with the next driver. For
> example cadence_ttc_bind() refuses TTC nodes that have a #pwm-cells
> property so that the PWM driver binds them instead. Any later walk of
> the parent's children or of the uclass then finds a device that was
> freed. With the simple malloc() the memory is not reused, but the
> refused device can still be found and probed through its uclass; with
> a full malloc() the memory is handed out again. Sandbox built without
> DM_DEVICE_REMOVE shows the latter with test.dts: the first driver for
> the multimatch-test node refuses it, the device for the next driver
> gets the same memory, and the boot hangs in uclass_find_next_free_seq().
>=20
> Build uclass_unbind_device() without DM_DEVICE_REMOVE as well, call it
> unconditionally on the error path, and take the device off its parent's
> list unconditionally too. The remaining clean-up, which only frees
> memory, stays conditional as before.
>=20
> Fixes: 5a87c4174d18 ("dm: core: Drop device removal error path when not s=
upported")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Changes in v2:
> - Build uclass_unbind_device() without DM_DEVICE_REMOVE, drop its stub
>   and call it unconditionally, instead of an else branch with list_del()
>   (Simon)
> - Mention the sandbox hang in the commit message
>=20
> Tested on sandbox_defconfig with DM_DEVICE_REMOVE disabled and LTO
> disabled: without this patch, booting with test.dtb hangs in
> uclass_find_next_free_seq() while binding multimatch-test (gdb shows
> the device of test_multimatch_second at the address just freed for
> test_multimatch_first); with it, sandbox boots and multimatch-test is
> bound to test_multimatch_second. 'ut dm' on sandbox_defconfig gives the
> same results with and without this patch. On xilinx_zynq_virt, which
> has SPL_DM_DEVICE_REMOVE disabled, SPL grows by 70 bytes of text.

We're sensitive in SPL to size growth and it's ~500 boards that have
SPL_DM=3Dy SPL_DM_DEVICE_REMOVE=3Dn. There's also the expectation that in
SPL things may not always be as robust, since it's going for just enough
to get U-Boot itself running. So what was the real case that v1 didn't
solve again exactly? Or was it just a code-cleanup that Simon was asking
for? Thanks.

--=20
Tom

--HPN+XJgnqYl65Xaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaupCdwAKCRAr4qD1Cr/k
CtvbAP9wVREJiYNaJDm0/3DsDQ47wvTVagWhyZsIoYRNWkAwGQEAyNDrhsXxT8MP
lkO62mZTK0JctmB2XQJp+DRf4fXjvw0=
=hXsE
-----END PGP SIGNATURE-----

--HPN+XJgnqYl65Xaq--
