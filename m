Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABD6C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 15:38:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B33260B83;
	Thu, 10 Sep 2026 15:38:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mW0jFzGhb27e; Thu, 10 Sep 2026 15:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6479B60B79
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789054699;
	b=g7EbRXhBXEPFosNW0puNpLViV0sEjXwFsCEVcxHwl9c+udpmj8XdztyFjIGYMu7G+CKj
	 dp/P1G54GYOUkFd2tegizFLtChhSTH72NisyBlsu9NixD4KE9NitHFMKQTtlRxLIIqq9U
	 tIxWkRzTqqPe8mhO0+zjUhPdgL0vDW3xw+zEW0IStKLsIhm0ZLyQvw+2WAr5nG0PJJPfW
	 Qpu/H9KkYdYdCSJ/pQqJ8CHHQ7k3zaSjGEN/82rmEQhaxGqof2hHF6GylyTCPZEEdiCAq
	 X8xoLwJdfIOoHVNFyWKnraOZLhccClTTlMmwYszufkTgfV/R3oUFez6n7pB6dEfDHzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789054699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3tgzGn5IVnA1oP3NM4YyUKjVgBBOL9b66ryaNLw1pBc=;
	b=FHC9GWiKw+f0I1OuyLz0F+UPyQFm9lPILCAb88OcCuegJvvvVsnjPhp1MPgfSjSke4eA
	 jWidKBX7yMROl/I2XcxX2rQ1p3bo4Q9w3Ff+6t5MH+WB9K/ixM/bDS3uQYXA9uG41jRSJ
	 Ry3fgBdbdqDthsrE9q8I0AQiD6XSJMYh42kddJiuLJp4y8YXz0/rbXbsPBV33pBJMySfi
	 z2Dn4RbBc10PIEA8c+B0eRWnjWnme2xDCCMCwJov70FYZaGVm0UywsXdaFMiRP3HXfU9L
	 F7kmiF3u+HIHDN2YZ7c1pR2nwVX8FmbtFiGlZtEUg0GVgi0liMqGBl5IzDGRQgP7EHQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789054699;
	bh=3tgzGn5IVnA1oP3NM4YyUKjVgBBOL9b66ryaNLw1pBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=POV3KdcADFpGKAT2+vSj/oIOK+iiWznJNYYmw+hi0HmlWX3iv4Vq/NXvNN23fNWcJ
	 9P8pKe+dA2H2azD/8szUOiX6tlNjWfIBSB+vikXQTG+/OpY92Y8/VnPBVvAFLHfL+B
	 H5KBO8NnOmlud2aBahXBWTFGKEzdJUMtUu1r0NPUz2d+ij8EnJNT4Jyg8XyfYUluTj
	 YqLz0XoGzE9kb1voNsr8AbD/Ja7RdO9WHxLdNRIXs8wQhtBnYWmZDGX+FRUEYVBix3
	 rSaoiwGi+FGBkcq5NBU5SH7bDHAR81zwYpnhR+lLa4dGvlqjO/mhZKymdJM3sfxw6C
	 7P5FayxT+dRtw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6479B60B79;
	Thu, 10 Sep 2026 15:38:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A28E5E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:38:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 88A7480F37
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:38:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xc9DNAdiHigN for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 15:38:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C397D80E5A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789054698;
 b=FBvgagoTe5n5S6Zv7HDoVbfs4lErqCnvMcGbDqEGKoWOckI+VL5qF1bxF0ND4nXaKIpa
 sViv+a29D1GQu4BJwvsbSLpSquiJdRcKUY1/pTfv+eYK1YqMPsqiZpdenO7gU3l5hgwcW
 4bt6241zktghRzPlWhX1Um/2swXgd5v240bMuuc86bBpJtbPZpzjNHfE+WLQp/AkDXbDu
 ePVkECoEgW2h97Pe2A02XhnkVW1OHmjDx/zh+2B6tNzc4u5Ddg4g+osQ5x5tjWRPjw0nU
 Y2H6KNoY+/MLgAn/qPSuvPMStnwStlG+cf9Dnpfai+82TRREo4rvmXJrrrO/M20BLcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789054698;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=3tgzGn5IVnA1oP3NM4YyUKjVgBBOL9b66ryaNLw1pBc=;
 b=iql3eH/UCvcJIBo0ugqA6ni4MSAiijnTN2tJ22dZ6Bn3lnm/NGpn8jjHXevI6ae7u09e
 euEyFQsfHdK73LxY/98JcOMeeXs6+gsNuyE56DmIPrVfLSt7fDqJbsiTahIMlhZW59tD8
 jM2h9k/hchP8GDPy7u57XrTlzOJ4fOoFdG3e+6ragty7pUSHJrZKTWOEgml7sGvdgsRYQ
 9oc3wgcsKf+dbj5bLoeu2w9ZEo662/ZJbyz+CroiSJfJHSv1wpjNI1EJWyo0yYkVKW78n
 7UFJZjzbFB45wIdIrWwMBmMsf9u/QGHRQXbBh8rDYxKaQox6hKL/t+27FHVI/UwC4Vg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=H1FjLLTB; 
 arc=none smtp.remote-ip="2001:4860:4864:20::2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=H1FjLLTB
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C397D80E5A
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:38:17 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-46add2afca9so4622684fac.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789054696; x=1789659496;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3tgzGn5IVnA1oP3NM4YyUKjVgBBOL9b66ryaNLw1pBc=;
 b=H1FjLLTBTEAcvouS5oh8v53MhtK8baWT+bbqIGBmgPCdx6ZGH3Qwrsp2dKbD+csU8W
 KTCH6cZquMsXLI4MwzMjx7C4lviBUBqpGPKzTwd1hzviK/UamSK0Cq9mpfkDP5Mw71p4
 Ve2R1Kwch7phD5Bp5FJkrZF+ws147yw+rhjiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789054696; x=1789659496;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3tgzGn5IVnA1oP3NM4YyUKjVgBBOL9b66ryaNLw1pBc=;
 b=VD5g3V9dG+ZMUf485jqkNW6t5K9lWW+muFZ48KbT9FWo72evFmsXDeUDODOKJxH48y
 DRdold1nOVe2pcSR1yr8WBg7J5jfABAyJKE4UrOsC4b1eHkqAqUSmvkl+p5HSIWzf0Jk
 BGR+ZttF9G8eMJbGpEZT8hRE/F8qSy3C38RTqVzpsGnmjxyACct4GZ0lsrFFddB+lFK7
 o4FtSxEkL0X1maWc7QDYXIaFy49XlqEcaSbW/eH0xsK/OglQIhBAQ86O/gA9D25MXqxD
 6caU5/XsfT1aMRZhd5yCfrHMDQI0OG2zursAHfatTsbLAf6+9zwQKbfg582ehSgjfICD
 XbSA==
X-Gm-Message-State: AFuF++kfIDUE0Cj9wRMbiA5cVwDjOLm08CbMLYIRu55q44Y0BXFF9Fnn
 m4IuMUTb5p7wuA/b5ybJGWSzoqZzH4yWifwJwvDw2XJPLA89R1qoWnb/vucAra4zU8I=
X-Gm-Gg: AYBFou0KQH8HmgAs/A2pqcNQw/w4FbQiEFaX3fwvxxICDKK4PThBOzUy2ADMcdKtT++
 7rI8P1MNKvsrPTp2oMjGQaz6fbtEDQ01qEtIQ0qsswxFJ1zUkCQRR0kG9/8xKBPK325M2nrOtyD
 mGSUYwm5CxH0zAoVzWSJlFEC8/nP7CsU1IO8HBBWASKif2Ox+BDLntStxDDYbSD4xhZjVyWCjEo
 9j+SI1LY1Xtdjau+1UeAijG2pLQlLj8dh2B6cDw5Y2z0AsN7KCv+FEiDQ65g2iY5JRi7ts3T7m4
 d8cNI4mNlZIPeWhQGesaWLLNF8PneAv8ZIMto8rMBdxxuCG0qOiqdzgqUwp+JzKLV/FVX2GtCKo
 aM7Wxl7UWMx9izTz6YPUigoURqTT2aobjaRmYAy5bjeftMAHaR8qHoQdy573ZcqK0f+0wr5VWYK
 kNmHsfwSxT4u8DuuPbhMvAME/GwcaUgYhBTMJGZpOpsNfCOTWnZtQTulcWQqgylbRYBI4ZOIXW4
 FbUbuCTSOKo0lupLxgoPFMe7Q/sTVcV94xFPRPVVdoQ2yGxoAo5rwSfx9RpaxF6kvWHaiBH7uUc
 qiIuHmy1+4j5Nce09shHLHlxBNcvIOU=
X-Received: by 2002:a05:6870:b2d3:b0:47c:3795:660c with SMTP id
 586e51a60fabf-47c3795b6femr6095350fac.5.1789054696236; 
 Thu, 10 Sep 2026 08:38:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47a7585b25esm8644265fac.11.2026.09.10.08.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 08:38:15 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:38:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] pci: Iterate over busses using uclass_foreach_dev_probe
Message-ID: <20260910153813.GJ1764417@bill-the-cat>
References: <20260809013229.444123-1-marek.vasut+renesas@mailbox.org>
 <b851170d-7541-4e0b-b98a-a92803f6bc98@linaro.org>
 <48c7cd0a-c9d5-4bab-98e3-69e0945bfa32@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oc9qmmW5wlybnJUw"
Content-Disposition: inline
In-Reply-To: <48c7cd0a-c9d5-4bab-98e3-69e0945bfa32@mailbox.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--oc9qmmW5wlybnJUw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 04:43:12PM +0200, Marek Vasut wrote:
> On 9/10/26 2:52 PM, Neil Armstrong wrote:
> > On 8/9/26 03:31, Marek Vasut wrote:
> > > Iterate over busses using uclass_foreach_dev_probe() instead of ad-hoc
> > > loop. The uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) =3D=3D 0=
 in
> > > the ad-hoc loop would break on first controller that does not link up
> > > in its .probe() function, which is undesired, as it prevents listing
> > > of PCIe devices on other controllers. Using uclass_get_device_by_seq()
> > > mitigates that problem, and, at the same time, simplifies the code.
> > >=20
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > ---
> > > Cc: Neil Armstrong <neil.armstrong@linaro.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.u-boot-project.org
> > > ---
> > > =A0 cmd/pci.c | 8 ++------
> > > =A0 1 file changed, 2 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/cmd/pci.c b/cmd/pci.c
> > > index 3c0aed50cae..d2a10aec41a 100644
> > > --- a/cmd/pci.c
> > > +++ b/cmd/pci.c
> > > @@ -550,14 +550,10 @@ static int do_pci(struct cmd_tbl *cmdtp, int
> > > flag, int argc, char *const argv[])
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (busnum =3D=3D -1) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (cmd !=3D 'r') {
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (busnum =3D 0;
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uclass_=
get_device_by_seq(UCLASS_PCI, busnum,
> > > &bus) =3D=3D 0;
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 busnum+=
+)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uclass_foreach_dev_pro=
be(UCLASS_PCI, bus)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pciin=
fo(bus, value, true);
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (busnum =3D 0;
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uclass_=
get_device_by_seq(UCLASS_PCI, busnum,
> > > &bus) =3D=3D 0;
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 busnum+=
+) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uclass_foreach_dev_pro=
be(UCLASS_PCI, bus) {
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Re=
gions are controller specific so skip
> > > non- root buses */
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (d=
evice_is_on_pci_bus(bus))
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 continue;
> >=20
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tom, could you please add this into next?
>=20
> Thank you both.

Neil volunteered to be PCI custodian a while ago, I'll let him grab it
with the other stuff he's been reviewing :)

--=20
Tom

--oc9qmmW5wlybnJUw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqLO4QAKCRAr4qD1Cr/k
Cg6UAQC8BdQcKS4bisLOVySLjiZqnBvbVyCtZAPbMkpJpFUbZgD/cpEUobIMwgvI
JMFw/dS8S1JxBngtgKWA9gM5QW7GHgw=
=6RG2
-----END PGP SIGNATURE-----

--oc9qmmW5wlybnJUw--
