Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1D5C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7E59406CD;
	Wed, 16 Sep 2026 13:09:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SLi4Q1eVEBMl; Wed, 16 Sep 2026 13:09:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 16BBC40792
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789564166;
	b=WckjExZvU7X5tU3gLI00Z/EuZnyhxVo7gcqJWNt8JiOHyrTT0YWqIz6jWlBxOfRJZhyg
	 9d8OVSdhaic347sXyw37AQ8i0AbIZ3nRifQCOCxdNf6T6E+vMBjst4hI19dxvq3BDTH9a
	 ZhVyUhuPkj+l9UDbD/tlDajA+LK7bVPIjC+0/35KGrhwCsgfLOJdChLYw+CzjIBvwTbyg
	 MlIIbh82j1ReHBt6Qof7UW0B1UCZTTNfNDJtcecbExG6bw3CTCQ7mxM4Ra6taBIp1v9xs
	 MskQEuLhcTDn61lZaOYS76R8Ikoza3qPceQgsrUOEnRhG53hE1NI5Wzh/C4xQVALENw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789564166;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OZaO3mr345rMqtBcUUOSkIono5fgG7YR6g16Py/rujE=;
	b=coa7+jL7VRDr7oa3/49vU2W3xeIsbmZ1xb06xMrbzSOR5jkao0/UBzq78ryMUYPv/UWN
	 Ot/B1+eUKVZWmsNEmosjGq3Jwd7ku9JX/MFBj3UyFVoljsEFUdLCfaDsYu68DSqGWXipR
	 Hr7ZvroB0qSLl+tZ/HoSj2I5tm1yW6cLb03JNCFx868n5JFWwp7Oz2YPMTfJNnrX89YHh
	 C1pkolmb3y+r76qUKi63yiVZviTl4UgKfX/oCPyi7G8hMvLyG9dKAe2oosUT40q/cUDIl
	 oykXDUTiRC6AD5SK3tsNOWcE3ZCjKxmwKlfAxi5gOLKLL/Pvjaqdg0/DaV00qYwj4wQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aHppjJ9A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789564166;
	bh=OZaO3mr345rMqtBcUUOSkIono5fgG7YR6g16Py/rujE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fYuAbJjuB3EGkF8ffaot11ESwZckPZhQIc+bj3a1uywJaa4mzaKmHEdqqXtiiKer1
	 1UqsPR10ud8Iu55G1JnjYtmSBFieJNoIDDuPQc9Y3i1x161wHgbiZWGtR7takac/ac
	 J9/mhAiQ5av1CmdJleXjzsB5t/oMghRU3u7hTojBpWpCDCloEJvfepSsaOZqdDzqPP
	 +FSyopsYGtwUhBkhaBvPoUOPjoEA5Q1UmkJvf5EtZsZX0z0qazcDlwkHyMIaMFSUv/
	 Qu6q4RSlxrd8hgupeVaowtt6E+sVClg+9y9+OX4BXO0W/LZnF1Q2gWwIRhLAbqIU4Q
	 SiuEPP96TzHyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16BBC40792;
	Wed, 16 Sep 2026 13:09:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE3B629B
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9122840308
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ljGw0-ORKcPL for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:47:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8E3BC403B2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562867;
 b=f/snYQwHvimNNe+2DuOKpevVXl1NFjlij3v3ECcgyYzbOVtNcmZnw+MxEdQxEppHYLTB
 Vmy92aekc1RB4MSd2dbl7+f9N8SxlgKQnrmvsqj7PElw6J5bnAPc1T6vyRQfH5kZ8dM1H
 x6yaoho1ZziWlkjpWBCHEOsBGGU5+kIwQQ0xbAq68WfjNQ3ZQCyzCt3B9Uv1+HBVi82Un
 /5rdKO06nAfcVtVkR6nFtWSILZSn84U2q0aZo/e47Mp+o9FtpqLoC0pqieYzDx7pGFANq
 Osd2+jyN51qDrSSsMU2yRWVX1j7adIoPx1RtTCYSvsSj250gAz37kZX80JFGVVwxy/g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562867;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=OZaO3mr345rMqtBcUUOSkIono5fgG7YR6g16Py/rujE=;
 b=rr+QhdZcDIYZb1JGvrjvF/BT0Be1vluiUWISgeakBjD/Sg4jE45pO1w3o1ONiHcIzDHw
 azzY6Ck/sixYVftuSwBAzYlQ8oE2TXSPx6n1A6e7zggGj1dgMdAQNawiFMmhpstI2CH28
 r98kmCvml3FIkIAjUlBV8Gzigsbsus8IAg/6ltfFXEvRyHSy7tuewoB3suEGvHypYbUPi
 +SR1u8IFX57QjJsSDEG0C6ItePm66iTMuTMrHfva2CNguaaN0BN2h4CQ+qv4nGRpJaVu0
 COxtgABLoVxC53V6QvQ2Vt7mEuz8Xj7Guu7eoN1hSJrgPcScKEOwJtcAVzgRsFp/FiA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aHppjJ9A; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=aHppjJ9A
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E3BC403B2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:47:46 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so6839575e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789562864; x=1790167664;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OZaO3mr345rMqtBcUUOSkIono5fgG7YR6g16Py/rujE=;
 b=aHppjJ9AZkpEilnH0EMi/aCfJeChk2XxavSuxyANnLDaXumUmVrS8/M2xVmSfs2b1W
 CQbCa6KJ/okiFH5Aw5Rz0LwwXf6M2BWprD+dkC5q4Jn068d70jCtxGta4Sk+eAVW5NTI
 5eege6Li3SJOTpjjYZYhdeRWST4mqyJ3RBuugGpgGp51Rv7jQvxaD9WUNqRGlKX5qPVk
 pxw/zo7MJGkAGe+J9OdjPBhJn9nSweqK6JYhCP3ng/H/5eB2+SYIWyjrJoZa8WXR3ffx
 mDhq/y003ulVXEVN7vQE+jcELCyNUccuhZzOCGEI47meD1CmS1j+78/q2M79qteJW1S4
 3h7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789562864; x=1790167664;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OZaO3mr345rMqtBcUUOSkIono5fgG7YR6g16Py/rujE=;
 b=1LIOk7RAk6Ijn9zPdzQBNbmKSq70aaYhKZ5Vw0qDZROZCYvp+vMuilPMeU0c2yl+rp
 HT2lsFSS3d3WwyMRZmXXsjFnXdsDezhyty5DhqmCeVNbKhVp4PE7kqHTqvRMENSXSS1F
 6MPbXu7GlRVJlmwtMfqmGIeRNPC0MQ1NPcenCWLpkvUPYt4euUpcQDfcgkL/B3NJFwh5
 OFliaD5xYrYKgk8KyjalV7l860ZtXDx2I8su/7ksGLDup6sJU68///3Qv/JE30zzSqBR
 7VGuFlTmp7toJa4HQNqMTOaa4+Ys34NUplHL3Oh295sQGPxAGzYuVPHNjvnBe8xfg5yH
 KsMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBylIO/rV2kiRN1xJg6XFjKmZYvCa6nKpmCkQXyBZCPVt7gDE+thSNyefXVjGxVacakM3HzTGL8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kU++CXA3zeiID8q8bYEcIn3a3CzlX1QKosQOBJc1IYZ1E/iVBG
 cWGLgBZ1tzQu01mPRW1zy+N2JHYCQiJvL1X5Fg+CfFYULnb3M5KurPcU
X-Gm-Gg: AYBFou0xOZ9EghC8L4Go6gkG1xgdavQrtm130qlzZjbaIT6l5TL5CvOv6D+v8ZYOspg
 Op+LKlIukzs+T1G6fmrb4zAQZQ8/mZHVQQNvQPqyzlFPilHKKEfj69qSLZPW8HmmYkSP3xS/RZF
 2f6yfGhQUu4BMvEOgI6x2Rhuk9VJ5h2dFW4zdUsAaljwvAw4Yyg3Gvs9Q0Qpgug0SYDSo7JjXei
 hIu4r2Zlor9pyCMkkhAnlpX4/vc/6PAU8N7EA0abG2lCUfiqKJfpZIjFb8rlDk9wGNGodrkIUU3
 6j1QVbbeRNnwuJEgjgL2eRLSQc3lKOoN/hwZnAibG97cZ7LAICdhlWd+JrSgFTWU+JqWbH2goIq
 8I7eBRaT69FvVVA8HKL7puhBaCTpYyvc4n0BWgtZ3vHG66rxpARYTfd3NQdHmXGQ57LOitWwDGS
 HaqS0UvXd8c4D0yfGKAz50Aw2k1AMq6LwRGNB94RlS7mzIpoif
X-Received: by 2002:a05:600c:c8a:b0:49c:fed6:cd3f with SMTP id
 5b1f17b1804b1-49ec0445958mr29292805e9.23.1789562863522; 
 Wed, 16 Sep 2026 05:47:43 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83da9a7csm73810815e9.11.2026.09.16.05.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:47:42 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:47:40 +0200
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
Message-ID: <aqqP7P-97FcjXdgU@eichest-laptop>
References: <20260914074314.12522-1-eichest@gmail.com>
 <20260914074314.12522-5-eichest@gmail.com>
 <7afa5ce4-060c-4bde-a820-2a579a0fad12@mailbox.org>
 <aqj6TwcnEeDZGQxb@eichest-laptop>
 <425b3ab2-1d26-4641-8f52-714088a2d25e@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425b3ab2-1d26-4641-8f52-714088a2d25e@mailbox.org>
X-Mailman-Approved-At: Wed, 16 Sep 2026 13:08:54 +0000
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

On Tue, Sep 15, 2026 at 04:24:59PM +0200, Marek Vasut wrote:
> On 9/15/26 9:57 AM, Stefan Eichenberger wrote:
> > On Mon, Sep 14, 2026 at 09:31:25PM +0200, Marek Vasut wrote:
> > > On 9/14/26 9:42 AM, Stefan Eichenberger wrote:
> > > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > > 
> > > > The i.MX95 SoC has two USB controllers, a DWC3 controller and a ChipIdea
> > > > controller. However, U-Boot might select a controller that is marked as
> > > > host only in the device tree when attempting to set up a USB gadget,
> > > > leading to failures in gadget mode.
> > > > 
> > > > Iterate over usb devices and skipping any that are marked host-only when
> > > > selecting the controller for gadget mode. This ensures that a controller
> > > > that is marked as device or otg is used for USB gadget functionality.
> > > > 
> > > > Verified on Verdin iMX95 hardware: "ums 0 mmc 0" now correctly flips
> > > > the ChipIdea OTG controller into device mode and enumerates on the
> > > > host PC.
> > > 
> > > What was the previous incorrect behavior ?
> > 
> > When I did a ums 0 mmc 0, the host only DWC3 controller was selected. It
> > is not host only by itself, but it is marked as host only for our board
> > in the device tree.
> > 
> > > 
> > > Does your board DT have /aliases { usb0 = &... } entry pointing to the
> > > chipidea controller already ? The controller indexing should match the
> > > aliases ordering.
> > 
> > Yes we use aliases. Interstingly the dwc3 controller is usb1 and the
> > chipidea controller is usb0.
> > 
> > aliases {
> > 	...
> > 	usb0 = &usb2;
> > 	usb1 = &usb3;
> > 	...
> > };
> > 
> > &usb2 {
> > 	dr_mode = "otg";
> > 	...
> > };
> > 
> > &usb3 {
> > 	...
> > 	&usb3_dwc3 {
> > 		dr_mode = "host";
> > 	};
> > 	...
> > };
> > 
> > So it seems this ordering is not respected when selecting the controller
> > for gadget mode. I have to test that again. However, I still think host
> > only devices should never be selected for gadget mode which is what this
> > patch tries to address. Or should e.g. ums 1 mmc 0 just fail for host
> > only controllers?
> 
> Yes
> 
> > In this scenario I assume the ordering is correct so
> > ums 1 would select the dwc3 host only controller.
> The ordering should respect the aliases enumeration, so ums 0 ... is CI HDRC
> and ums 1 is DWC3 . Can you check the U-Boot control DT /aliases node to be
> sure the ordering there is as expected ?
> 
> => fdt addr $fdtcontroladdr
> => fdt print /aliases

aliases {
        can0 = "/soc/bus@44000000/can@443a0000";
        can1 = "/soc/bus@42000000/can@425b0000";
        eeprom0 = "/soc/bus@44000000/i2c@44350000/eeprom@50";
        ethernet0 = "/soc/system-controller@4cde0000/pcie@4ca00000/ethernet@0,0";
        ethernet1 = "/soc/system-controller@4cde0000/pcie@4ca00000/ethernet@8,0";
        i2c0 = "/soc/bus@44000000/i2c@44350000";
        i2c1 = "/soc/bus@42000000/i2c@42540000";
        i2c2 = "/soc/bus@42000000/i2c@42530000";
        i2c3 = "/soc/bus@42000000/i3c@42520000";
        i2c4 = "/soc/bus@42000000/i2c@426b0000";
        mmc0 = "/soc/bus@42800000/mmc@42850000";
        mmc1 = "/soc/bus@42800000/mmc@42860000";
        mmc2 = "/soc/bus@42800000/mmc@428b0000";
        rtc0 = "/soc/bus@44000000/i2c@44350000/rtc@32";
        rtc1 = "/firmware/scmi/protocol@81";
        serial0 = "/soc/bus@42000000/serial@42690000";
        serial1 = "/soc/bus@42000000/serial@426a0000";
        serial2 = "/soc/bus@44000000/serial@44380000";
        serial3 = "/soc/bus@44000000/serial@44390000";
        serial4 = "/soc/bus@42000000/serial@425a0000";
        usb0 = "/soc/usb@4c200000";
        usb1 = "/soc/usb@4c010010";
        eeprom1 = "/soc/bus@42000000/i2c@42540000/eeprom@57";
};

I think I found what I missed. When I was originally testing it, the
CI_UDC driver was not a driver model driver, therefore the alias for
usb2 (alias usb0) did not work. Now with the driver model driver, it
indeed works:
Verdin iMX95 # ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3b48000
\

Verdin iMX95 # ums 1 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3b48000
No USB device found
Couldn't init USB controller.

So I can drop this patch with the next series, thanks a lot!

Regards,
Stefan
