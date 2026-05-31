Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E47CCD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 14:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3374984839;
	Sun, 31 May 2026 16:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JPOeYpQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C679846FA; Sun, 31 May 2026 12:08:24 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62DC0846E6
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 12:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raziebe@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so99365415e9.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 03:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780222102; cv=none;
 d=google.com; s=arc-20240605;
 b=iuirToAVHaEqu70UVvLikK5Wb9asajE+DsIz6KSgmS1cC3nH7j2cr9nqD8cCVFQ8Ko
 OU3ajav79dww5tSoS9XWpaBV2TevLmNQRT4ELYfCoCP0MOZIIwpsDhIgXzmgJNB3Q7ra
 7PoGXJQoEsVHZdi8iIeabiL3Z+PqE+psaXr8z1qnOtrc3iZ0Fj2aHIONxQFFmqT55m7K
 hvL7/fa4eGTdjIuZah2BEX3uDxU7NWBilGe2ZMHujICoNXPuLcCx9mznha3QuptwbKgI
 m0GsG4ZuL+pvhQySTjvH/7K/f8ZPA9AyJAckHC56Ou+M4jTxOIddXoFUtchCmwpzqE/l
 5m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jRROMglRN/lZQiifVDHwOXI+sw2K5IfiRp42B5CSZ5Y=;
 fh=0DYF/OfnomlsnuCz7BF1se5iGCbx1yidu4HIwWoglM4=;
 b=B3e3qAl3uKrRf44tNLXM3MLS5Xy2MyHo2NX+NPuEmiu3l7PyHQ8x9ATEyNqWpNFqLF
 /8LHhTgUWhNzRSMwPeehdQIPeC0iGIyP491fk5Qq+wSR+EnEitHAoxsjo91MBmvEQ2If
 OSV5qoreQNGUhmvSqGHQDpI8GqIal4tL4iXmD1KhHctheRhQPWo7avDVOSE1JptbNxcY
 yLtAwbezjI754RZqeulO8JoqMTWCSr88xC9eRoLDsK1Cw7uYOIhDegjQv2Z3N80AEQwd
 TI5HSNRY1Kj8V8L4aT/9E5tHwBDnqFlEMGaourYNbuMVtHrpWB8hVouJ2qBrmJeH7jhP
 3eng==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780222102; x=1780826902; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jRROMglRN/lZQiifVDHwOXI+sw2K5IfiRp42B5CSZ5Y=;
 b=JPOeYpQX2PV3yKoQJZMCcFMGwonmmfXcUUTC5q+IGkfniW4qO9YjwKWWjAWvJNt1Dl
 ARC2N3znCSAJc00Uju2YndPiy0WLMpgHPDA6B/UdHrFYhv9+rCyIAF9T+Eo81mZobpq3
 y7unKg+ldLIqtb8+w6jz6u7lzU3vG8z5KPm1wp2+56AQWFPC175b2Qw/+QTxzxNvYJSL
 0jHmkpd7mygSuilsNIuMnsTPCGisdhq3nhXdMSAJLwaeRp6qFx7Wa9SWyrL4oHhNIepi
 uilHVX1jkhkQxZ73l4tTTOqNcIvPo1HSYUuVHX9Nn9TfJmbCPSYXqddA5GAoP0IxHhav
 6NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780222102; x=1780826902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jRROMglRN/lZQiifVDHwOXI+sw2K5IfiRp42B5CSZ5Y=;
 b=DIPwSy1GTGDOmozXuDhtOowGszU66RrOjCa20UEtjygpthpAAwdRb2i06LZCjJaOmp
 sO4OegNcx0/TFPBfaluSl0CDMcBy1iXPjcIIvvKZV/vbnRFuJm+S0q/dOONWssMG+Shb
 SBe7/3mJeCRzEDJ6GYxyzR9Snsl9E1mtbqTpPJUDyIMUah6wfhWZeH3L9VfowgQcbfFx
 T7oEKA41M9cDw5KJPasGL7T7hz7644xQ+h6SveW8TVQb79ezWDiMtpV40rWWfCJXQ9LD
 +1xVfoe8mmJcy4a8S574Qod2bE4gPo9/Pm8KZxkpzCJ73eU3aUWtwanKUK1UYtgmqvk3
 QJKw==
X-Gm-Message-State: AOJu0YzFdMOVqIsH1mLLxz+ZUnQGAD8ZBmCSZAfSGfn5wTJ3K4GDOQpV
 qlENvcthmpS3oPVOCVoJRQKAs2L65n6giu3fuP0hO5NlzFprLug0AkXSer2SKIaJ9uohtP38gZ1
 zZCdRSdpR49pExWlZvQ0Hdc8NIKNmYFKqEw==
X-Gm-Gg: Acq92OFFfwyYx5R4kmHVxLjXV+0JxQ4mJ00hxRy1XQGT7igjgdLxcH3BBOXKkhwms5n
 0npjyqvKRohO9aUfuLjEoKdodtWZyl+dL/mit3HR7VPmqpoIzI4h/9U2U9H7Q4DUeQ9cZDk3199
 f43JeWkAOoLw2wZ0wALzRtIRFlJYL+eEqysMPtfbkpV60MrLSJ8eIrZlJuTpED65oEjCttAHR9i
 nTgOn4abrQ/2vPdPlta79JRPusfop/org/QumEYvLW1hOSHzW4cRCIR7/85l0/7pMB6MhDja4DJ
 xS29P1Hn5loFX+seTU2NeYFMcOu2PpJTYewgZ50TMtfhx1hWxdvHav2taWkP
X-Received: by 2002:a05:600c:4f89:b0:48a:9540:1a3a with SMTP id
 5b1f17b1804b1-490a292c7aamr128423235e9.8.1780222101743; Sun, 31 May 2026
 03:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAPB=Z-rjEF5fCXcYWfeskz3W3u16FoW4VN48O-OZTz+fp81Q3A@mail.gmail.com>
 <a97ae4de-3159-4678-ab25-e5ce9ff1e12d@linaro.org>
 <CAPB=Z-rJpjJxPHaFvuvvrPBG6yvr1vjAxzvjBML1bbnqzU8fZQ@mail.gmail.com>
 <0b5b81a1-9e17-4523-90ef-aad2bf934115@linaro.org>
In-Reply-To: <0b5b81a1-9e17-4523-90ef-aad2bf934115@linaro.org>
From: Raz <raziebe@gmail.com>
Date: Sun, 31 May 2026 13:08:10 +0300
X-Gm-Features: AVHnY4JoxaHRU4JUjdF3aytcOd7-Rym5d2wCEJ8wyB_Oc87_Ks81WJ-ylDRcLvI
Message-ID: <CAPB=Z-pKp3W4SSAaOgR3twmzRvL76bCQjWmVbj5g1=4G_DBzxA@mail.gmail.com>
Subject: Re: UFS boot and UFS tool
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 31 May 2026 16:30:00 +0200
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

Hey Neil
I just posted ufs-tool for uboot.
I tested them to compile in the master, and checked them to run in my
own older branch.
At the moment, I extend ufs-tool to support auto provisioning.


On Wed, May 20, 2026 at 3:47=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Hi,
>
>
> On 5/20/26 08:34, Raz wrote:
> > There are many commands. ufs luns is a common example.  see patch
> > attached please.
>
> Good, the changeset looks sane, please split the whole change into
> logical and incremental changes, in the following order for example:
> - fixes & typo fixups
> - API export
> - new API
> - initial ufs cmd changes to accept subcommands
> - add subcommands
>
> Those commands are nice but I would like a way to "protect" those
> so you can't change the LUNs desc accidentally, like perhaps
> an intermediate command like "ufs allow-modify-desc" which asks
> for a confirmation in order to call other commands which can
> modify the descriptors.
>
> Thanks,
> Neil
>
> >
> > # ufs luns
> > | LUN 0       | LUN 1       | LUN 2       | LUN 3       | LUN 4       |
> > | 16 MB       | 16 MB       | 4 MB        | 2000 MB     | 80000 MB    |
> >
> > On Tue, May 19, 2026 at 6:47=E2=80=AFPM Neil Armstrong
> > <neil.armstrong@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> On 5/19/26 13:53, Raz wrote:
> >>> Hey,
> >>>
> >>> I have added a ufs_tool driver to my U-Boot repository. It extends th=
e
> >>> ufs command to provide access to IDNs and flags. Mainly, it allows
> >>> creating and listing LUNs.
> >>
> >> This is something very welcome!
> >>
> >>>
> >>> In addition, I am currently adding UFS functionality to the environme=
nt.
> >>
> >> Which kind of functionalities ?
> >>
> >>>
> >>> 1. Are there any other engineers working on it ?
> >>
> >> AFAIK no, you're free to send,
> >>
> >>> 2. What is the procedure of posting a code ? Pull requests or emails =
?
> >>
> >> It's mainly aligned on the Linux practices, you can find the U-Boot pa=
rticularities in
> >> https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending=
-updated-patch-versions
> >>
> >> If you're unsure about the features implementation, please tag the pat=
ches as RFC.
> >>
> >> Thanks,
> >> Neil
>
