Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D36CA5FE6
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 13:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D992280D74;
	Sun,  4 Oct 2026 13:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZxnTIi-DtFa; Sun,  4 Oct 2026 13:12:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0035380D45
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791119567;
	b=ILNSWDBEAE2nzGYfCEvp7MCv/O0pltupKmdi2RYs5kvz+kKvoLdxGcYtIHrK+nXlCsfb
	 vNvCLMH1uq98eJat2QmR0ffYbSakBER50LT41wkAN94gd32At+ydJarIfvrySzLxppVJ3
	 KkS2JxBjGexOj33rkK4l/6UT47aJQRycO4+PYJhkB0NPMpYLvSRfdbK1OskWBz7QjlMfr
	 xqan8YSvTLcw9H+X+HqrA2xawjqRr67bNUBkquKCkY5dNEFFNxJrltLcOXVMWKfDpVfvo
	 ItkwTh6WENxhGytmTr4cMsCM+9v0o4iO0vVsO+WibSam5Pv3TgXi0gDZ/bj9WlTO7TQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791119567;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=c694ERdlCWvxijcmMEBsGryabXmhObIuPxz0qxvMjKw=;
	b=LLaGCvM90cuIp8Z/yIIdrcA4eMsnNxLtcKg1Gw69g2ybCQvA4X3z1u5NFhNiz1Dr9ly2
	 xdyOUaCir0t2Zr56eBQDWf9mY1XYPjGqduRtg8dzM6BHdFPqy45QDoUzyazC0NhWqv8iq
	 z1EHHw2zikYcNrRKy/S9+cnXc2ITSruSV2/mOjwjcK6N5abPAgMnjkt2jKIvlwI7kG9cM
	 UCPlQgWcU7vGZs7lJf1v5SfwcroJ/LenCRpkvxJ+YhmVilVbG66lHbACZ/B1v/BsJqclU
	 LbJIsBwmHdL1daAuIOfCLbHGqF93M+vERB2yF86NToUpMevuJNVPQ63Q/WVsr4jJRGg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=none header.from=tezduyar.com;
	dkim=pass header.d=tezduyar-com.20251104.gappssmtp.com header.i=@tezduyar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=J6OJzm1O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791119567;
	bh=c694ERdlCWvxijcmMEBsGryabXmhObIuPxz0qxvMjKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DcRMy9Rqj6HonV/PREAmixf/gbRJSUEUaQDG7E+VqFu4A0kxxEROoThOy3boEotMp
	 rhghDlrSkP4P16XTYb6sIm7c6aSx6snh8SeYo41uv9iT12X4usnj1cvyfk8CW2jp6s
	 t2DMau3P1ZqM8ez+zD/B+ZsYljZKxN1mIHhbkzPamR57Pj0uXIyQxc7+DNDIZ/qLxy
	 b79TTW6NnMifALOxLM6mmPaDkdzjPEi97VcPNZJIpcUtpK6xTmedz4DDu8/cRJOe+w
	 gRWNZclVHdl3qw8M9Ztff1ymKUFHHlG/hqoisGSkuHTHs1Cg3/yPBBqweybaBGDCYG
	 ipaJyOtyRecHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0035380D45;
	Sun,  4 Oct 2026 13:12:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DA341A6
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 11:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 232FB80DC5
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 11:46:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rwQEoTrjrR-v for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 11:46:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6433280CBF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791114410;
 b=Js6Z1q64D4JR29SW9cHqR8/+QFvuGQjWtR++mWCaX7RuzPdrTVA/D+pUNfd3Kd5e/olM
 0eNA5HABxZMbUo/t/8mbzbKDH5s75EubpIfw2bvWYzMEmtJKEuuA3Zr9JiiGJE4cfBMU6
 S0BX+jezLRLeQTAHjt9QbeGvWn6D524L3RyseM+SAWMKKdOQsan99KfdrhJ3zkRwlyl09
 L6+BlT5v/w2fCRKnVRwcaOTB5YsCTVx3z56cD711gbCJnMYWE3UQFtPOuMbHDZUkk+uHK
 QuRm+zY9KZibskwsLuX/Yv+JL/BxgMqxWowmyjYQxtYOgHMcDd2mGNuXIVhre8kzO3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791114410;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=c694ERdlCWvxijcmMEBsGryabXmhObIuPxz0qxvMjKw=;
 b=sPsqcKB9O1ZI/Bb37BpfJQqdlt4s7B68qnBDp9nuUl6jMCpNSyfm+QcLb1fxzi52//D0
 VjHcI82tIC/ZYNQzxt7oV7i54INtBQsbQhwbvyOaBXEo8kGvh1O5+o24/1QvD9fopuIz6
 q2SP/s+GhV8HWYY1NvVdXa2T55JDzNm/I3gCNfMtdgNqQhBnbfNFIH0Z9+jnffLEetwBc
 /tc3TbccsMlcsmgc1MMBdGEk+mJckNIjHU6MGrlnVcJBRUvJ6xKUHhDJ30eX1S2zSQzJt
 p4Ya8K7EWm9Spv6cmKPPDFd+v78QBsmiUCfXbvwgLjbQrgjMtGm99A7JxGgu2m3P3SA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=tezduyar.com; 
 dkim=pass header.d=tezduyar-com.20251104.gappssmtp.com
 header.i=@tezduyar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=J6OJzm1O; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=umut@tezduyar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=tezduyar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tezduyar-com.20251104.gappssmtp.com
 header.i=@tezduyar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=J6OJzm1O
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6433280CBF
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 11:46:48 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9adcso1304996a12.0
 for <u-boot@lists.u-boot-project.org>; Sun, 04 Oct 2026 04:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791114406; cv=none;
 d=google.com; s=arc-20260327;
 b=svM7pilx7ovrh1BdJ9YCbb8RKkn1Hy1bXepaHSAOrgUYNzmQIaRLyrMjiauBYNV2l7
 6oU/qI70eKAa5hrsTXEx1tqfB8WN+aC+F7NOfgUQ2md3IeupevlUExapK62owPiOlQrs
 5M0Fw2QcfQpwu9SXlsT1gTmJyRTM6bCOkdklpcM+NJn/ecHabPc9WkMRCSlbW/Bz1ghr
 qaWlilBR6Y+umO427kfpktG0m6YQaoBxcS5FkUcdOLeIJoufPd3JFe8jKpYh5wWYB5V9
 HQhILPdWSQ3Bxke7FPvR1N3NsoUtIXy1C7eVALjc1mXH9FKgLjTw8m2aHnbTYYRUDnuK
 IVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c694ERdlCWvxijcmMEBsGryabXmhObIuPxz0qxvMjKw=;
 fh=qgasSHWK9ABu1C4X6rYrv/IN0O2UMctworj4pvZ1u7s=;
 b=ic/R2xoJJWhbCI10Vp9xh/Cfxs+CaSKAwH3vrV/MnHRJ/lCwW0Plsnq6RvRi9m3Wzs
 dlt1ScQGguqGPmwkTS+0uKIbU6yUIVh2rKvF9gu8lGY3/fIA6LxkCL9sw97hX273Mlzb
 vK9TR2R7I2SqOv0S0NGFVQdPGBfaeWhwyJT3pu1AdLmt7SaFxYu8TDGq0KIhjIrUDaFZ
 85NYQERCHOFUl57oac0BtFHP0uyl383DomaLvZL6LLBbSjYl0HiistF9xvqdlEqu3SxC
 6vW6UmDkRogCv2F1rNKsl3PKFyPWk2bHcfg+SyQDHeQMA+bpXtg5UeDaMjwfjsxWWEUo
 yaVg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tezduyar-com.20251104.gappssmtp.com; s=20251104; t=1791114406; x=1791719206;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c694ERdlCWvxijcmMEBsGryabXmhObIuPxz0qxvMjKw=;
 b=J6OJzm1Oc1KrgGPDATFjuj4y6gQoA20RrsgZqMAP4Ip9avMTrK5hqYriVRsINF72af
 81Pgw2OpWuN3t56VzYi3L83PHyTB8BM58A9p9aLC8NjyAwV0xR1lIgGrOTAU9bKGcrtb
 GXYqWsM5OMZI9UsloE0KX0AWw5DnmlsC/iUQl6n0d6PRj4JCnAtesQcONRKbs1hV8Y/B
 H38Bk0KQBEi8LUnx0PRfYUQpKuYS2YZ0NVgjiuQl6jhYdDQ0I4Bjukg4+vx3InrW0sFq
 6ZQJQvmuO0I45I1jL66W3A3n2q1sP9QhvvP4sv4P/aEF7BAj9Ge2zMD2UIlLn0+SKIxl
 x+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791114406; x=1791719206;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c694ERdlCWvxijcmMEBsGryabXmhObIuPxz0qxvMjKw=;
 b=P1ozEY3aRh4OtuR6zwkFB7T65jCWJyA0s2qxNA0jbQVdhYpfrvJcZA0h0v6uaU2rAd
 UXWwFCPzzhwj3rbLZgLt6ASbdEg3XNaeZf3e2Jm0t+3bI1PII8F50s8/XIC9r1lmgJNg
 Z/ijDX3YpahdJHhG1J9XMl1dYs+GmDJAD6HWOT9FusHkI8sAnSAmeri/mDy7VJoj0HSa
 h9zaxf757WwERE70BbhDROpbADGyFRXYTORw7IIzBq9tIREULIVBK+z7sVia1Rf1wpLL
 W7TpBMi98ShYlEs2IUJia/5eg3DB/OWm7qfJzBNUs8NAS8M7fBxR4o8S7jWdZr8kAyuh
 LSXw==
X-Gm-Message-State: AFq9FYINjYVKYNcppqt77CzDIRfdbKbbm2A70SquMD9WxXutx0Qs4Esr
 ZdC5rxwGUogXvBVAVrAFU259wPo+iaPC6HHkU9r/THLRCf0Vje1GHYZ8JALt2Hdp9b9ej2j2g/K
 IJtxXcBM0y8ituLMFc6baDKmZDhKg0A1tddcpbP8zNCHsF1l6LW4HvazDqwoq
X-Gm-Gg: AYBFou1jYwomwljBiH99iqOKRyTHTA7B2rPn8bIt6TQwsXOCrMMIqV8dLQSW82JOGym
 KHL/B0ht5yGiYiTXSEhZ15DNRtC6xhTXBEQU5ydDWKdP6VO3SvtLpPwwovCoKGcIZxVYdIjLyr3
 4ymnp1MD3Jt2jQUZ6czavHhYdsGBkrfPBuuPnSpNobxQkpvZr25IZivgjhYmnZKoD+kFmfPPGQx
 EBenehSZSf2dwIUKpxujBdR0kmKHbqqqOEpM+4a5qRPlBRimFLWeVbvdGp1ZmZrgWYWgpHergZm
 UVBK9BXgft4sQVl5nSvtZfwD84xW3gQwZc8Fp1onEpcfcc66PQIWy8ekqhAtUaNM8Jf0Zz5y9E0
 0RZoo3JDwnQ==
X-Received: by 2002:a05:6402:a00d:b0:6af:836e:2d14 with SMTP id
 4fb4d7f45d1cf-6af9e37981cmr5062072a12.40.1791114406468; Sun, 04 Oct 2026
 04:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFKnvs4fEmyqAbNFobx1UR_KXhvrA_MqttNEpktrjNAH3vjv7w@mail.gmail.com>
 <CAFLszTgHB4tZz7=eEk0QvOxVwUvSwC7zy1QqtUMtMtEmKXcJsg@mail.gmail.com>
In-Reply-To: <CAFLszTgHB4tZz7=eEk0QvOxVwUvSwC7zy1QqtUMtMtEmKXcJsg@mail.gmail.com>
From: Umut Tezduyar Lindskog <umut@tezduyar.com>
Date: Sun, 4 Oct 2026 13:46:20 +0200
X-Gm-Features: AclHuK8AWgu0uzBXMXyan2zlttwZVIWO_SWKFOAM2LJbTA1JcJ8fESljofzRr7o
Message-ID: <CAFKnvs5V4mv-nsFfe7UYeiE79wO8R3=pi82Ubu=dWswCoUfLaA@mail.gmail.com>
Subject: Re: Can u-boot UEFI provider implementation boot systemd-boot /
 systemd-stub?
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000f32cb2065d025103"
X-Mailman-Approved-At: Sun, 04 Oct 2026 13:12:43 +0000
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

--000000000000f32cb2065d025103
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Simon,

Yes, ultimately I want to boot a UKI containing systemd-stub, but I am also
interested in running systemd-boot itself as an EFI application.

The chain I have in mind on arm64 is roughly:

U-Boot -> U-Boot EFI implementation -> systemd-boot -> UKI / systemd-stub
-> Linux

My main question is whether U-Boot=E2=80=99s EFI implementation provides en=
ough of
the UEFI services/protocols expected by systemd-boot and systemd-stub,
without having to use something like an EDK II payload.

The EFI call logging you mention sounds particularly useful for this. Do
you have a pointer to those patches? I would be interested in using it to
boot systemd-boot/UKI and compare the EFI calls actually exercised against
what U-Boot currently implements.

Regards,
Umut

On Sat, Oct 3, 2026 at 4:30=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:

> Hi Umut,
>
> On Thu, 10 Sept 2026 at 13:14, Umut Tezduyar Lindskog <umut@tezduyar.com>
> wrote:
> >
> > Hello,
> >
> > My understanding is that u-boot has its own limited UEFI provider
> implementation unlike some other boot loaders bundling open source UEFI
> payloads.
> >
> > Has anyone tried to use u-boot's UEFI provider implementation on arm64
> with EFI applications systemd-boot and systemd-stub?
> >
> > Using AI, I mapped all the API calls done by these programs to UEFI
> service / protocol. Most of the text input output functionality and
> graphics functionality is irrelevant for my purposes.
> >
> > ASCII text mapping table below:
>
> I think you are referring to UKI (which includes the stub)? I have not
> tried it, but there is a good chance that it works. I did send some
> patches for an EFI log which keeps track of the calls which are made.
>
> Regards,
> Simon
>

--000000000000f32cb2065d025103
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Simon,<br><br>Yes, ultimately I want to boot a UKI =
containing systemd-stub, but I am also interested in running systemd-boot i=
tself as an EFI application.<br><br>The chain I have in mind on arm64 is ro=
ughly:<br><div><br></div><div>U-Boot -&gt; U-Boot EFI implementation -&gt; =
systemd-boot -&gt; UKI / systemd-stub -&gt; Linux<br></div><div><br></div><=
div>My main question is whether U-Boot=E2=80=99s EFI implementation provide=
s enough of the UEFI services/protocols expected by systemd-boot and system=
d-stub, without having to use something like an EDK II payload.<br><br>The =
EFI call logging you mention sounds particularly useful for this. Do you ha=
ve a pointer to those patches? I would be interested in using it to boot sy=
stemd-boot/UKI and compare the EFI calls actually exercised against what U-=
Boot currently implements.<br><br>Regards,<br>Umut<br></div></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Sat, Oct 3, 2026 at 4:30=E2=80=AFPM Simon Glass &lt;<a href=3D"ma=
ilto:sjg@chromium.org">sjg@chromium.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hi Umut,<br>
<br>
On Thu, 10 Sept 2026 at 13:14, Umut Tezduyar Lindskog &lt;<a href=3D"mailto=
:umut@tezduyar.com" target=3D"_blank">umut@tezduyar.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hello,<br>
&gt;<br>
&gt; My understanding is that u-boot has its own limited UEFI provider impl=
ementation unlike some other boot loaders bundling open source UEFI payload=
s.<br>
&gt;<br>
&gt; Has anyone tried to use u-boot&#39;s UEFI provider implementation on a=
rm64 with EFI applications systemd-boot and systemd-stub?<br>
&gt;<br>
&gt; Using AI, I mapped all the API calls done by these programs to UEFI se=
rvice / protocol. Most of the text input output functionality and graphics =
functionality is irrelevant for my purposes.<br>
&gt;<br>
&gt; ASCII text mapping table below:<br>
<br>
I think you are referring to UKI (which includes the stub)? I have not<br>
tried it, but there is a good chance that it works. I did send some<br>
patches for an EFI log which keeps track of the calls which are made.<br>
<br>
Regards,<br>
Simon<br>
</blockquote></div>

--000000000000f32cb2065d025103--
