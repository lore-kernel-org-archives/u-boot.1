Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A52AC98338
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 16:51:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 637B980E40;
	Sun, 27 Sep 2026 16:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JThbl1wfIPJe; Sun, 27 Sep 2026 16:51:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 825ED80E33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527884;
	b=ptEg542iPQzi9Yj8B0cIawBTCcBfNrYCpFMTmhJVRbnayicM96QDWDg7eXftYN2SHzKb
	 xqKXFVXCo8i6ArwCWkicALD3oIpg8h3lZ/h6mjvhVqqQvuO6rrB2wvFe435Is0C7/jCqy
	 KqTCshZXNiA4pHaolkL6WrGgb1E7nJq0/JAfr7/j/FjJ/dIDD51F4eLcxFzgjfqAAz9+e
	 nFsZTV2jXT+RV5DRyED9FL3dkaYslqmQrw1/8HjDBpd96rm3x96weRoAs+OJAnbsUMnyw
	 dp/zeLygCtnvpc3rRVKdNCP7sLEyS3MwmeUUzh32ykTO50o7hrXd1JOOxfd0oknyO4g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790527884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6tggxMdrywxn1DUFt8i90rYFcHa7B535aoe8M9/hvC0=;
	b=A96ZZjrEIl9MmorCWomYfp9dA8Z7Vvv+cLflQQJX35NdjiWQzWQCgT3NeXtHPaq+LeZY
	 OkNMtxekf6ohaK7IqeOOHlPEGUbUneboIKME7rg1+Xk+/zjN5kPIqJ0/Wgq8sjmvqI3Eu
	 698tQBcpYIdw/WSDCHMNgP//MwHW1Xq/6lTVmh0b5X687oAS1sst0qwRVnzRF2gdBgn4N
	 nOf0oeiY6wl2NhYYbw3gvSBMK32zcSaQsnsESa8U7e0HNu6oSy60pZo7G0ST/O1cYMnRw
	 tfhG0Gp87F746BtTGsy5vHnClbYR6ET7X66Bgqod+ppRQZRKcE+9cGdvRNiiLx21u/Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790527884;
	bh=6tggxMdrywxn1DUFt8i90rYFcHa7B535aoe8M9/hvC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GP9ko288hPQX/HTQRXbaPWw8v5tWVQwCSXK/0Hx1g0FBxyusp/L0gxeuybi961rTH
	 BJC6a1jDa0UUUE93I97X6VOtLdHQYIacARYGGngjhmlsjTFnjtR58Gnhb6NWDerTQV
	 IZtON4aGoJPLWvS0aCQGa1u5hxiuljfWphBPqYK0zsaw6m/uzGRRZF3zh2lsqekgzP
	 ZnaCKW35Bmelb0Alc6k36SKTLfO208FLpY+fKc/61eL+7KfoDzO8csuv7SwPMvnegY
	 S3zprqvaOaBojj8PdqYGh2RjJQKE+IoDtJtTwx2CBOdSGbrY8EfcxTNOpzsz8GnoqT
	 KtVnfZ6nJE/GQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 825ED80E33;
	Sun, 27 Sep 2026 16:51:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 943FD3D8
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 879C9400BE
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WsN_PkgJrvso for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 16:51:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 59E5D40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790527881;
 b=erJ18M2PgLO1M2UhKLn/AF0rdQRHLiq9PHUT+bIc9jTIs0Th0+3WGOFK8QVce88aiF51
 OCcLk3d0My7uFCCEphggjPXY0YWAlmCNxbm5p2dzB5XoQxQ94LT/+Rk7EnmZhjazjGmG0
 Fpsi/4vT4zFfYrpeOWCvHR8Q48yHmr+lFp6xLA1L/kDyqYzyEmx509Nw+cQR87syEIFyt
 86/O5BDtnCxBjWuBYPmddiRJeHMU4RjqUIJCuRvrY8hK/YR/50IhF3HjZmgwen/0Tfs+8
 4xGFb84m2/u5ps6BxAYAwGbpyvSYFWNhLECbQboM1nHjEZ4QcMjnRFhxSbZnpiKST+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790527881;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=6tggxMdrywxn1DUFt8i90rYFcHa7B535aoe8M9/hvC0=;
 b=WtCu//4b4RAhh2jXaz+lfRnc/2QGs0+cCss4yl15Cx3pHO2wZ/Cj4PAxwmeb2etjX2U5
 cx97/06ItMaj30Wai+SzK9JKXIZzCgClOT6+qO2sE4vIp/fNvcwANKw18kA3NaItVeIXT
 FLW8Kz37UZO74DAbiQvBLmBu/nAcaJR6GsMLc1xhttKwdv2T0X6ePLsVZM/mkWMHvdYLm
 T3Q2L+bEoHfc+bZVS7X/c3DOkPif7f/osxygIwsfZ/KS7oTeU3PFH9fu1ae2RfcfBPbg+
 ly2LARpIjXHvGqFmUG+Km0jKe2N4E6hTM/viREXo1gt0+ViTmATcpUscd4ASKBhjvmQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=G5EzCN4I; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=G5EzCN4I
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 59E5D40068
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 16:51:20 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a8038a9f10so2940523a12.1
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 09:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790527879; cv=none;
 d=google.com; s=arc-20260327;
 b=TQ0jJew85Pr0pymSHfJKnXMxwZUjYoVIRZ2ZIzJTGIRypAHZIJjCstG7Bye0T4FIAh
 B1tU9YQ0Q+MFfBHKxLuyGnXAR8U/M7GugvaKBUQe6580m2LcxMTytBor8tdNrAo4oA8i
 /oqzFWr/0EF6Cu4FDOK6V8e2oFz6DhSca+zZmBAtnx82FL96MYGjKsnBt6vzDJ8FO4fo
 B8DdGNsJN+WYrCzANPfygEXtBclT8YcWvgO9cGvDdTJd+gJBUEBj/pO+hfgqgZaxrlLw
 BegkwzGTSRYDKH5bvZMqIsNDFEB0pt59PfAFhbiWaCXbsdW9gca6LHQbmsXHvzZF0rIt
 jFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6tggxMdrywxn1DUFt8i90rYFcHa7B535aoe8M9/hvC0=;
 fh=Z/bPs/ZubL3KEIJj8FO4m8zIGTLdbFbeXsuaG/WXupg=;
 b=QpiOktKzK7BNfNb4SIms09dKuHY7MBOREPPfDuafRN3OxdJG0yIs1dn8SDl4/Uq7Zq
 ajVSD5VkbEnGQZo7f+HoUVSGGmy+PNp1E/iznR/5tlpDg2pgr567PA/9SzDyc9SS0/Rd
 tfyZlg/2UpMsWnXRknj9UW+Gy0HsDoghBfjGtndtZ3vQaMj3rn8o03jeyOemxV/KLafV
 jsZ1paSLZEDND0b0Cgg01TectKTFSXd5kP3LiMoLfm2kQZFcPSSbRxJ7Nr3T3pE5qEFX
 177mJfjShtGPbHg2+AzVj833cf1mpZZ//nCxOZeopr86gx/nMoc8JO3Y1Yfx8FoUKch5
 qP+w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790527879; x=1791132679;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6tggxMdrywxn1DUFt8i90rYFcHa7B535aoe8M9/hvC0=;
 b=G5EzCN4I7zZYvNjE4Foeb1fZWqjHnLFyc9oihWAQBwgEyN0hg2OkLIMn35Gt7sQ1TQ
 o0bDxRC+TRamUOfZk71TtGWM5Zt8avA+rSMRhhrax+aspm0TzISbTrQCoc8UBwAEcWe4
 ExkXNxw3n8edJF5EvgC8egytBpqrbHLF+De5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790527879; x=1791132679;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6tggxMdrywxn1DUFt8i90rYFcHa7B535aoe8M9/hvC0=;
 b=DjIWS2rfyKlr/mxBpECV9KfCkGtCP46IrrvNupkVX2x1gtb2qqZrFB12JB0ZdBkBAQ
 052zABsnFB0m2rBmP/IGSEStiFgqCUZBi2fX4S2xnrifCZ2ep2ohLV4D/04b3FHaDNzk
 uNrZnlBwt3ZDUBKY6swY8yadZdvbpNNwNVTL5zlsS4w+dNXSbTRiBVjFyxd5Z3zGMErv
 E2BzhSrQmb5L2mMTbLX8IIfASfudhbUAasEosmJsEVGg0aDHIVRftMmCL0cIrOqsFyNa
 aiqKTMaHvVWqw6i/j1cfWB29rDlaxCIeXdcjURqJQBbHZpdWPMEIkxnur6u81BieLFc2
 FpKQ==
X-Gm-Message-State: AFq9FYLHLH5SdpCsfR5UI32Lxu0PqI3O/IvbqT+/LMARA6m/X6Gzl86G
 QE9TjOrJ3uxUx65ZctZNC5tUlI33XoMNk3OhNGGN1XONr07TJdyfstcGyoA9n42U9qjFzbw0zba
 sU2np737QDnL6dOjbYvPBUcacJEgS8f5CgqjYp9u055jkHHCQfp6bmA==
X-Gm-Gg: AYBFou2esubi9PFmsSc4RTS7c7pMUKbqbMUOXOFMjfzI4+KukWtvEG42mXZ4f+gDXt6
 UgV0NqPBDZQKC7jGzXX5nfCOq3fELFb1WkNxdHhNBhFG99zYzH8Tkw6IC8v2eXuA/PWC225p6tk
 tS8bzpdz2tebk/ChNcsbcRlqbWH+rAbY7ATWbRDKQwbHkXvF3qCN7tTibvJvM0thg/BdF0Oe96F
 +6fjQBOECN8hXb0t8PiNYqQOWyWlD2Sneo351wKp2MJPw4G7cBN5dqbAKU92EtdzuR2e7EYdQMK
 XWJNxRVQ0i4A6pWh166x5QpPyJwaEQrwSnQODGDIiQL3ov1f1ZZtoLELcbQCdMoX
X-Received: by 2002:a05:6402:c1c1:b0:6aa:ee55:a650 with SMTP id
 4fb4d7f45d1cf-6aaee55acf1mr3887184a12.37.1790527879024; Sun, 27 Sep 2026
 09:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260831142800.25966-1-aristo.chen@canonical.com>
 <20260831142800.25966-3-aristo.chen@canonical.com>
 <CAFLszTj0H71E8K8mJS_Oc6dtvPTeQT9m_7A++91XL_H=SkV3hQ@mail.gmail.com>
 <CAA=k7=mn25hODFV2OPu0t7=dArdXDv0FYUug5-RoEr6_zBLw5A@mail.gmail.com>
In-Reply-To: <CAA=k7=mn25hODFV2OPu0t7=dArdXDv0FYUug5-RoEr6_zBLw5A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 10:51:07 -0600
X-Gm-Features: AclHuK_AR5R0XOGgH8Ra29OBmf64FK-d-lG3uKZl91OoIO_ELJH6TjTfuQx_Guc
Message-ID: <CAFLszTi2T_PVLpn4wE4Kyb+d7mNh2s8p6341MY44HHbD4rvM6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: boot: Check that rauc rejects over-long slot
 names
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Martin Schwan <m.schwan@phytec.de>, Denis Mukhin <dmukhin@ford.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Aristo,

On Wed, 23 Sept 2026 at 01:00, Aristo Chen <aristo.chen@canonical.com> wrot=
e:
>
> Hi Simon,
>
> On Sat, Sep 19, 2026 at 4:45=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Aristo,
> >
> > On 2026-08-31T14:25:38, Aristo Chen <aristo.chen@canonical.com> wrote:
> > > test: boot: Check that rauc rejects over-long slot names
> > >
> > > Boot the RAUC bootflow after setting BOOT_ORDER to a 33-character slo=
t
> > > name, one more than fits the "BOOT_<slot>_LEFT" env-var name buffer. =
The
> > > boot must now fail with -ENAMETOOLONG.
> > >
> > > Before the previous commit the name overflowed the stack buffer; as n=
o
> > > such variable exists the boot then failed with -ENOENT, hiding the
> > > overflow.
> > >
> > > Also check the accepted side of the boundary: a 32-character name, th=
e
> > > longest that fits, must pass the length check and fail only with -ENO=
ENT
> > > because its BOOT_<slot>_LEFT variable does not exist.
> > >
> > > Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> > >
> > > test/boot/bootflow.c | 23 +++++++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> >
> > Since the boundary is boot_left_name(), please exercise the scan path
> > too - distro_rauc_read_bootflow() calls it against
> > CONFIG_BOOTMETH_RAUC_BOOT_ORDER, which is what a user is most likely
> > to hit. The current test only reaches find_active_slot() via
> > BOOT_ORDER at boot time.
>
> During a scan the only names that reach boot_left_name() are the entries
> of CONFIG_BOOTMETH_RAUC_BOOT_ORDER, a compile-time string ("A B" on
> sandbox). The BOOT_ORDER entries seen at scan time go through get_slot()
> in distro_rauc_scan_parts() instead, which marks the bootflow invalid
> when a name does not match a configured slot, so no env-var name is
> built from them. The test cannot change the Kconfig value at run time,
> so covering the rejecting side of the scan path would need either a
> dedicated sandbox configuration (which would require adapting or
> excluding the existing rauc test, since the bootflow becomes invalid)
> or a test hook that lets the scan path take an alternate default
> order. The scan path's normal accepted-input case is exercised by every
> scan in bootflow_rauc(), and it goes through the same helper the
> boot-time test drives across the 32/33-char boundary. If you still
> want the rejecting Kconfig scan path covered, I can add a dedicated
> test configuration, although that seems disproportionate for this fix.

That seems OK to me...we are going to end up with more need to test
internal functions, but most of the other tests don't, so it's not
something you need to pioneer.

I was a bit confused perhaps because patchwork died while I was
checking the patches.

> I re-checked both patches on top of current next (951132236b9): they
> apply cleanly and bootflow_rauc passes, so I will hold off on a resend
> unless you or Tom prefer one.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
