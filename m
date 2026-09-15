Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EB1C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC6A480BEA;
	Tue, 15 Sep 2026 15:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7K1XwC9bD7Di; Tue, 15 Sep 2026 15:52:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C2D1880C48
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789487527;
	b=L6K6btGNdzYRd+OHIrt9SQPVaGmaqvWiHL/4pOHR0JiM+bfpKoXr+hp3o3XF2ACQVfWH
	 +ZAubTDbCiNkyDm/PPwf4FE+ouFN99c0y0RwKnlPEaa2vdqRnVpj/bYxW94EOixgFaq+6
	 50UNLpYxMbOVQKdSx5EfW+wJFfJaLrHWWta+rZqGrsFl99DAOg/XvPeqUD2BCUYytgYjA
	 VakylN95zSjsab4kL4NjMuGMscfRDfsnZg0EC2Crmjz7zljL9LshJKs5yD9of9wrsnSOG
	 pyW0b7X4QXSUKuVNhEh09efvgeS7fMHih379be+qsBKjDsnSdNpGQ3lpx8Gs5K7itVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789487527;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=giTrykZGtQNNdiPfHTuPBSUyBi1gAghb7/TcaEIow1s=;
	b=BlqyK7A8C86xPKObZk/8FOYoDkqsQgYx9SbziGxXVoCS/TiUvP/ej56l+D8/+O6FuoOX
	 8Mj01k/w2mQlrjU2nOY4uI6tx0nnML1DoSDqEat7qR1BsZGw6AED4euUbZUc97XNmXwHv
	 ucw435A7ortfbPduGG4+KxZN7Iu5YqV3muvOFa8Z+Oa/AEgvqcErMfi4tK6gU7AJaeK0J
	 S//JEh9fo/t75xDfL2GSxY2N8SY8UqEEvPjaXatPxdl8CTSZGIiuRsPtCVCwnpee7zMMR
	 xt2bAuO13HWQYQrMFrThU2xe05sD9MA3dlZ4+tgeYtNDZOcOEs0648G+NuiQQ3Nir5w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789487527;
	bh=giTrykZGtQNNdiPfHTuPBSUyBi1gAghb7/TcaEIow1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tf/oM0ydFJzO6eje616KjQlXgs9qls2ryRWIFlkfjk3pjWFJUZ1nvztazUzuSGduX
	 YJg1q3GTSssYALJDCtDsG6Xoxno32qkt5p+QQBdaYn0gJ5ZRvt5rZS7kPIsNIdAHK1
	 wunAwYZ5Kdlqo3QwZPLwuZRSEg4qxbHTnkWwl8b2o2AykyV7PDJ7nchBEHn7+D9WOj
	 obGahg9oVGFN9mo5jyn7tJ4nvU9PlXEGdLwyg4YxQMYffTIjtmNbOIrbKhA8CrUpbJ
	 /VRimZQj9bhK3M7QYn3x1uG/EDL/3xQQBDOsH59D6k2Dm7115SabnIjfnmrVUnYH90
	 YfZr6PnS4jgFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C2D1880C48;
	Tue, 15 Sep 2026 15:52:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3888E224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 07:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07777404F4
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 07:57:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id agoUPAiVQCSw for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 07:57:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1939B40564
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789459029;
 b=MY8byY4eApCLRZZ5Jq19gnI5PokBiDOdspG3apO/grtnvKc7KRnc2jkavO1fWdA/ACmP
 j/QCS+Uy/ozBnFmo6U6X/omygey6d7yXXCX3EYmi6nfqYkoDUqEaLrYJ8h1vKofEg8C3j
 ggu50PcLh/7YRDZm6lMcltmKhiOGfmrRIXbn6OBP88/BcGmwnOx9leqs/pnR3aOfPw/Tp
 m0y4Im0DgW8gjcLpVGyabLaO22Ie+Mv0YmGBaxmb4AFLV0Gx/qDgSBeE1KVVZhNa91fUt
 XTL/dJ6k2IojLtTQwMMK4zCp+fsqwz1yiqs8FjDZst9ED3uR7vO8BS1oX2sLsSSy1sA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789459029;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=giTrykZGtQNNdiPfHTuPBSUyBi1gAghb7/TcaEIow1s=;
 b=jw7z2IJpFFl0yUFYsRG8FlLCJlA4EO6bc4/3aFd2pqyodGPgUe1uxn3i3e93hwqAIdix
 D2hxBhQsm/SckXcVfi0KmQ5ERChMz+UoQDUrJYqKh/OuLSzxm7oHlV1DSMLsDMU88NRoe
 hnIB09CjK3k0F9IMYd78NxiLVbj5TgJpWIlnm/xIWK877reGtjW7IE6YP9UsQ2VD2OrKC
 Qlbw9SNdEZcrdr0CFuWAr6TQ1Mx5Enj0ET63d3xU+f7fVSIWa6Q9ODBlyG/QVT8gF0IZb
 8ROqWq6M/SgAv6doSXVOfa5ZfjPcx2A+ElqknqiRMmkPBitl+rQOtyDQyi7luVen8pA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Rhs9NXQa; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Rhs9NXQa
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1939B40564
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 07:57:08 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-484366874b0so1611976f8f.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789459026; x=1790063826;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=giTrykZGtQNNdiPfHTuPBSUyBi1gAghb7/TcaEIow1s=;
 b=Rhs9NXQaT64GxjP9vbF0r1BVYI5Hn0hwLo61D5O3QVDg/7oKaSHb6NiK+IgBg1zC5r
 6nv6m5yyq7I0In0SJ6eNY9wepRHWN0iwIbUQrMSJGgwF/nTzK8xeqD6dV7bRgdpOXaUP
 HTexvMvZgnlKyif1sM7ibLHma2TMjCghGYnbNph4nTRj+/JJUB2V/Rd9sv0nsJd7yOUR
 MAhSmftwlRIQzYMRwrPKvHyErpMbVCHT30T9HbonRl+SFh1mhAlk6ip2yF13fnKhy2Ps
 WuffRUGkmmxxPOj5q3yV17vdhyb8dwKvVhxCWgNrVDnu0Gj/ijTmyhyakS/QkDnlnFrW
 GK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789459026; x=1790063826;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=giTrykZGtQNNdiPfHTuPBSUyBi1gAghb7/TcaEIow1s=;
 b=AfHx0NBC3Q03Z/5Mb79RDhw0ouJcRpPh6QMlHkEucdmiROQnM8trvsEQQiFh1J67kb
 SGBP11P8mo1M2ovI2QntVaGX0Pl4vDm/exTxO5T/tqKKc+2gkukZUqBbelxDqYh+nr8j
 Y9cKoVsAfklbCtF9RRsjhwbC8M+UJSgUnjbvRTuVuU8i0mJQehQf3Du4iIojE8t9icqm
 E+xyWjzVPrjJNyuuE6vM8fnvRnVilDROQl8qRO3GbKNMRqcjZEuvYCs0Z13rsAmEGjyD
 DrzD1+2aYOZyk+a0ODgDkLQtNGUYg6+H6sBvdOPm2/Whl1qGZYmY5nPvI5tGkv2uS0cx
 fqYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwf675jDmk4+paQS5L9lgKytKSGHA33CIUjyFrUTPWTnZVRlrY9Yh+mEPwECv+WQmm96KKG+ZA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n6O7cUIs+v0kB0UYiYd586uaWPLMwY8sC20vz+bHZopnX4Lp1W
 R52vrbJOyYBieJZuuuBRhf/kynGy5cuAS0S+F2p2HoLIcbJVohyCOBph
X-Gm-Gg: AYBFou0zHnVnURiRzlBuEpgp9q0/ynNSywgZD52il/x7zanJTC3X0Hze6IfPQ2IOnTP
 cThzF5hhmECcKP6hR+i9g7lCVjP2G6Wv4Q/gkleYDbMbrG+Ggslyg4To2jzxhooGifN4h5tBIuP
 kyDrtZBGKu09NNt9O2qNpuftQqhsF3U3SnonSE+WbhmL2CWXX4ms5LX1jLYI+ONomyfm0OOehIt
 rX6px+chJAhz4O70GP+XK+f/2OewXOCNIEyOlyHaUt5Dnu3FGtaOX+rnYox9i0IxaKTaI0371SJ
 A3RDSOvnFJtAD01a9h9RZDw/DiztLOxKr/OUeAGELhBdAtmOvNgg8hSk0RVGPewijdZx/zMGptK
 liKN7Lta3lf/YDwuLMoCwdarm1Xd6lTIhIjkDnDC+7IMq07NQDpeqNwheZ8td/HjgJ4f/bx4P1J
 T18USQhWsP2G2rAOXbchBrdWQqDD2eXQOyGLlQIzin2axOcRYsm9SqMtllcV6DEgBa4vYMPgU=
X-Received: by 2002:a5d:5d0b:0:b0:487:57d:18e6 with SMTP id
 ffacd0b85a97d-487057d1b59mr6766254f8f.20.1789459026206; 
 Tue, 15 Sep 2026 00:57:06 -0700 (PDT)
Received: from eichest-laptop ([77.109.188.37])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb36e4a6sm34520252f8f.37.2026.09.15.00.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:57:05 -0700 (PDT)
Date: Tue, 15 Sep 2026 09:57:03 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 lukma@denx.de, mkorpershoek@kernel.org, antoine.gouby@toradex.com,
 alice.guo@nxp.com, stefan.eichenberger@toradex.com,
 sjg@chromium.org, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, pbrobinson@gmail.com,
 quentin.schulz@cherry.de, jbx6244@gmail.com, ye.li@nxp.com,
 xu.yang_2@nxp.com, bmeng.cn@gmail.com, xypron.glpk@gmx.de,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 4/7] usb: skip host-only devices when picking the ehci
 gadget controller
Message-ID: <aqj6TwcnEeDZGQxb@eichest-laptop>
References: <20260914074314.12522-1-eichest@gmail.com>
 <20260914074314.12522-5-eichest@gmail.com>
 <7afa5ce4-060c-4bde-a820-2a579a0fad12@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7afa5ce4-060c-4bde-a820-2a579a0fad12@mailbox.org>
X-Mailman-Approved-At: Tue, 15 Sep 2026 15:52:02 +0000
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

On Mon, Sep 14, 2026 at 09:31:25PM +0200, Marek Vasut wrote:
> On 9/14/26 9:42 AM, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > The i.MX95 SoC has two USB controllers, a DWC3 controller and a ChipIdea
> > controller. However, U-Boot might select a controller that is marked as
> > host only in the device tree when attempting to set up a USB gadget,
> > leading to failures in gadget mode.
> > 
> > Iterate over usb devices and skipping any that are marked host-only when
> > selecting the controller for gadget mode. This ensures that a controller
> > that is marked as device or otg is used for USB gadget functionality.
> > 
> > Verified on Verdin iMX95 hardware: "ums 0 mmc 0" now correctly flips
> > the ChipIdea OTG controller into device mode and enumerates on the
> > host PC.
> 
> What was the previous incorrect behavior ?

When I did a ums 0 mmc 0, the host only DWC3 controller was selected. It
is not host only by itself, but it is marked as host only for our board
in the device tree.

> 
> Does your board DT have /aliases { usb0 = &... } entry pointing to the
> chipidea controller already ? The controller indexing should match the
> aliases ordering.

Yes we use aliases. Interstingly the dwc3 controller is usb1 and the
chipidea controller is usb0. 

aliases {
	...
	usb0 = &usb2;
	usb1 = &usb3;
	...
};

&usb2 {
	dr_mode = "otg";
	...
};

&usb3 {
	...
	&usb3_dwc3 {
		dr_mode = "host";
	};
	...
};

So it seems this ordering is not respected when selecting the controller
for gadget mode. I have to test that again. However, I still think host
only devices should never be selected for gadget mode which is what this
patch tries to address. Or should e.g. ums 1 mmc 0 just fail for host
only controllers? In this scenario I assume the ordering is correct so
ums 1 would select the dwc3 host only controller.

Regards,
Stefan
