Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45295C98332
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 14:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D569A8119E;
	Sat, 26 Sep 2026 14:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKOAiQnrZ62i; Sat, 26 Sep 2026 14:39:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 070AC811A5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790433564;
	b=eifT2kCUhHWqfc04+OR65VZmcVKS7KgBeX0UUtEW4AqNRcC7ctPzhIhUk7nY4kkNWcUp
	 6JHPJgibI48/0CC4RuijAscWZtNWaei9xAAHAnKeTtm4TrZao12EK6PsQOEa0R8BhrahR
	 KsVecM8WjHFBQ2X3J3aHZ/a2syOYw43WU+oR7Wzm+iBVyZdgu5VyvgkHTTZSpot4UYg4X
	 iaFST3exdpXC0MnTyMtuQUvxKOgnVAJ+ut5WLLmA94N9yEY1AXQYod/t0B2pEKZx+VxqX
	 xdx8B0yF/GxCE/K9Obsf+HH+tAY8B/QT1Doz+9p6s2FMukwU0LiPAoIJgqXs+i9XGHQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790433564;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=LbK36p937ukLf3+AokU+/vSoAOXD0f+mOZU6EnH+fhY=;
	b=czP62CUDiYghX5o7ftq67L9NzMTJqxtUwFgeYLvNJe4qxGhNY6QkAmyPGwrUSv0E1p/s
	 aU18SevvOs8nkK9+E9dgzpCKxaRkaPnkyVB15rmmjfsJs/uxVBXioJeQpepK4qyb88UuL
	 1MolZm4Qr2mHsHL+3mZ6HnXGiGmG+p1R1xvdDivxa4Q/9OzGboHsTzTZj+2UlI+VWZbUL
	 9e2qLuKnLCi+Pl9orR6A349dmAeVi5A8oApxqf4ig66Cs55f7kUD+EiVdr9erxSIxvFGg
	 nyyZ2g+NVq+oQSyC6VoMTPD2S+MXq8hgZcidGwne0w7QOkx6Ph4YIveaSJ5+t4FhZQg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790433564;
	bh=LbK36p937ukLf3+AokU+/vSoAOXD0f+mOZU6EnH+fhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j9VbIZI/Rl73Ir9Gju3TKnYRwFrRXbn+BZ5TmtR6xG6Fyf0wuQ00X6TPuCjKq8Vdh
	 7wlA2xfiPO6RsqIpwJo3+keb+oTorkURlsn2QnM97w7qd8C9mhB6TNT1a0btDfgkDH
	 ALJJCDVhrq/LWsFE3rijokb9PIDs5QjfsOyGbnoe3NOpKfU/h1/5wyMfSH1IvZ34qY
	 PCgFT+Ue4YIQd8vNFlEex4ZPC4Fh1m4DLMlC/Dq3myyXpgiabspMHRdVMsdJWAnY5p
	 /JtS1S/PNI37j6x7k+z9cJlh9agpvkD8a+3wVlfsvHdym28jKTxQI5+imIL8AxYQ5n
	 NNKFbEJIHCdWA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 070AC811A5;
	Sat, 26 Sep 2026 14:39:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 168A7335
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 14:39:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0B896067F
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 14:39:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id etMMfeQ1KKI3 for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 14:39:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EABD66065A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790433561;
 b=eM3fxSHM0mzmaACvnMAgkcwrc82YrniWFAJYs4lk6VUZO9HXj1PtuGDmMzzoY02RLfvl
 wBZndshUKvEC4XmQVeRrgP3Lm2vkvENOZSZl1ZH2CaAYTd9t2zHMLtOOsroe0RIwtcoHI
 lHbEG2A1mrtgsDp1NMnNRAH1UlMxGq++NmgeIhYAe2nf7T1i1n2OhXRj8TD1L1v2hvPJ2
 p6pnFbTgUxpF/7m3es1KQMR7Rjw8sKrYmiWP9j5nonakFCIG5Xv+XRk2zAAfqP/tK/1Ly
 20ApDlm77JjYt/AaNhbf3t2Kye+KZReJzLFLc2wS31N2fA6c2ucDj7gDWhItXx6V9Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790433561;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=LbK36p937ukLf3+AokU+/vSoAOXD0f+mOZU6EnH+fhY=;
 b=VWsUim2tWQM7L0TfEFRzM5zVlrq6PuomXZKdRy0ejx8WDWJHmASvyyB3SIE+TCmJ4EeB
 RPKFfv1tTMJf2+OJrnapaldIFnIT9qbfj9kZn9QvkqyAvaxP3kbVqLjArYJu7z0aOKQUs
 bS+FxqllQtOqsbkbZOcWwVr29vMRGXwoTn1OJ77Z394ONzYCCLHzgiaDq+Y5nLm59frxX
 VaTLjSHktfiaLr8nQ/2do/8ymipS0zxUpfrSdOgHpqfiHBozav7n+Q3ILmRkL+53R0Od5
 kVx+PQuYkfq6GCmZ4J9CxcDMwI1+3d2Tuu0WGXybD2bSzSw2aiu/QqPYzVPy+z1lI5g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OC87TmhJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=romain.beauxis@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=OC87TmhJ
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EABD66065A
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 14:39:20 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a605c198fdso2737255a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790433558; cv=none;
 d=google.com; s=arc-20260327;
 b=be7Jg69FDVLJ8woOdRhvSnFw4cm2Ol/RKXVI0UYGK8L4smUUO0AUqph+OCW+NikF3X
 o6Zk6+BSRg+tWeHRVpStjCxXvVdDhOAN0KdrN5pPkoKKMSqnyS5FlbVBusmiGboZZMcx
 YjXvV25a3XTH2bJIcEk9zdAptxU51NbuTNMNwajmBxJGUIxrXaRFZvjbJLgaS5QdbuTK
 9QzwTLogFdxhkXzRAT3IUT0KRmft42OP2bLVotXfdRMDTUPgIyTr6xTCEu/Jb9VGnMln
 wlYcwQmB4y5nzq06sMQCGLT7tP8xC8rH7KmaRMvNzTGfjMa/FSsjdVtN+RavvHogF/Wf
 72jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LbK36p937ukLf3+AokU+/vSoAOXD0f+mOZU6EnH+fhY=;
 fh=qzY9BPtJQ8ezqvmTyfCyVGT7Henx501M4PKyjOGCbao=;
 b=JX39wwrxVeCz3Ap26vghH83eBbyb9xk7QpLF3ZHyr9a+f5UZrNUXejN+mtx86b0ECu
 RSUnrrIaPv8jAJFOcjJkiYHIZR5vBqqTr4ThC3SFma9+j44Ju2F1kjFIz9ywlVQfR1HN
 9UTUwMQA/4sLcUiX/avRHh69xEe2PRxSosFGaLipv71Rra7nVyZ4yhRtI1fkaWd3k0Te
 WXrY5RmteHjTBIFuB84qgjpRhAdJ5ezGAYjA2XLjwCLIduLyK5xY26o0yo1A9BWHAN45
 rR0ykf7vaGiYPftzk2t5xJXJZQlAe7cN2VFiXS8hLFjsqIKYhGvs++ns2WjHMjc2Me0/
 2wnA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790433558; x=1791038358;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LbK36p937ukLf3+AokU+/vSoAOXD0f+mOZU6EnH+fhY=;
 b=OC87TmhJKDoQ/pB0kj+r0CCCtmKfS1cR9JFqhkRsWGErAmwMgSfMxSu5Bfu7Rw6S83
 gMhQtIWNei6kzVqYPAIPLPP4vuPdRzKsH+8xKo0I9SqL2MPj9ukHHVtTa60Jew/TyCG7
 1uLsuyPl1EgJFF5MU/HmdwUxbDIdGQJ8R2neKs+63k0Stan4u+7J2LcSXYxfph4ltotl
 sLfQlO4LgL64nZnKZ+TTtD7qko0fdBAg2hbxt9pPOF2DZXP/VwkgWqa2K5HZbhkC+QGo
 HEeRnxpt6PMs4ydabgxrlJZiQZPwh3eowtS9TGgUrpbVh5J2JxN3AicKYVVaoOOoLV3U
 aSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790433558; x=1791038358;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LbK36p937ukLf3+AokU+/vSoAOXD0f+mOZU6EnH+fhY=;
 b=w+7MlWnybhHdkHQlWlDOFJetyla3Ph3GFaXOwpUfYi0qFMrVSs//5zeDFkm7GDXmUz
 9yguE+cKwTmQfHZx9+EaPKUcR9KOe5+2gFIfCde6p95mPCZdmz9BItbtqPnaNSWkn7YP
 4y0PZRuy5VOJivp8f9PKKjcOY90htqEwz4Fo7BdCgeGHrGVa1YkbH7uymyY24pqviw8Z
 17nTP8m/jzxc4zXGcKIp23HU6a3ROjbqEQPr70fOKu6Grxm2qoPfsxcFFNMjQs6Nat7/
 Ma8LjOUvYPfwD18cHdpxmaY9W8MGCyG9qKN9eqqtzTUUAsCDC3NjTh/++vadMwSkWEwv
 fNhw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs0ZOXbMZ5YPfS91iUpnboplNmX37PXQGumy8DbLSl8/++S926/LR3gtj07Ku/a/mdF9pcMv4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lGK0RjZ5B7YWgv/ewZwFvvYOoCBNWZD6QoxvuQmE7Qkp2qcEsT
 pLpLLBtXgC04m9Dl721R0upi5HXQQulzx6oqFc/6zKBTYzVfKmH4HeYpJl8+1ZlLCXVTDSxLW+W
 1UNsJ3umKyK2XlTIWWSQSs67L5hXSROg=
X-Gm-Gg: AYBFou2jezsCXEcEA4wu72FSXAfjqZQRGs9Uiphd5CUy4gkjM6hE935zZ7EscjPrKv5
 xOWOwbpH8cgbuoQf9r1d37nUSdJ7Y529K5umi+IS6aKMLxYCGZoBELpYnLLvFSWgoe1Yu7y5d43
 5pXfYDjNarkRB9daUHax+Au8Z+smHPiCc/ok6QLjfOfMlnpFwmUF105ZwJ8Ar2RqGCTRz7JON3l
 qFcTuGPCUo3JcBuLnjlQobfbR9z9jECzsv3lrFrOclXxOmfQYlpj6fM2pKBwzjn+mw08hp1ZLbZ
 7T+6npVB4TKxDf4Mw9qoMbHvczft00ysUW/GS/E3ClCqaBGxy+EUjiduCyo6NgnDmRES79hPgWa
 FBmagXTNl56YTL4znkxWejvXFFosKNeK0WUD0K2goGa5buO5ny5YmCLD0Ii0EEfgnEqM=
X-Received: by 2002:a05:6402:1f44:b0:6aa:c3d8:da1 with SMTP id
 4fb4d7f45d1cf-6aac8ecf448mr6712397a12.9.1790433558195; Sat, 26 Sep 2026
 07:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260911203229.25414-1-romain.beauxis@gmail.com>
 <2b012875-7ac6-4c74-841e-b5da14391e3d@mailbox.org>
 <CABWZ6OQ8xqFUQDt8FyODZPzDC=SFOcxr7bDe0eAF5K0OpwTy4g@mail.gmail.com>
 <6c15d243-812c-4674-bee2-7d3fb5671beb@mailbox.org>
 <CABWZ6OSpK+KA8VoQ_Y7nywXjeUzRLEnfTXa=RWdgKZ8RHwRw-g@mail.gmail.com>
 <a614b702-9d8a-4e7e-8a7f-ab50b5fceb22@mailbox.org>
In-Reply-To: <a614b702-9d8a-4e7e-8a7f-ab50b5fceb22@mailbox.org>
From: Romain Beauxis <romain.beauxis@gmail.com>
Date: Sat, 26 Sep 2026 09:39:03 -0500
X-Gm-Features: AclHuK-6-p7rwr0UbFIj2PRMkI9_lXeB23fShi9CrCzegMV1oQx1lpATpdKyOkI
Message-ID: <CABWZ6OQ2shtc95y-3Obe2sfhUkWVUTQnEC86w5HVWsDG8hF-uw@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.u-boot-project.org, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

Le sam. 26 sept. 2026 =C3=A0 00:20, Marek Vasut <marek.vasut@mailbox.org> a=
 =C3=A9crit :
>
> On 9/26/26 5:35 AM, Romain Beauxis wrote:
> > Le mer. 16 sept. 2026 =C3=A0 23:47, Marek Vasut <marek.vasut@mailbox.or=
g> a
> > =C3=A9crit :
> >>
> >> On 9/16/26 9:24 PM, Romain Beauxis wrote:
> >>> Le sam. 12 sept. 2026 =C3=A0 22:04, Marek Vasut <marek.vasut@mailbox.=
org> a
> >>> =C3=A9crit :
> >>>>
> >>>> On 9/11/26 10:32 PM, Romain Beauxis wrote:
> >>>>> Neither bootm nor EFI ExitBootServices() stops USB controllers
> >>>>> explicitly. Both only remove devices whose driver sets
> >>>>> DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, s=
o a
> >>>>> controller brought up by "usb start", e.g. from preboot for a USB
> >>>>> keyboard, is handed to the OS still running.
> >>>>>
> >>>>> Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff.
> > This
> >>>>> is the path "usb stop" already takes: the xHCI is reset, its PHYs a=
re
> >>>>> shut down and its clocks and resets are released. Child devices suc=
h
> > as
> >>>>> hubs, storage and keyboards are removed first, and a controller
> > already
> >>>>> stopped by "usb stop" is skipped. xhci-pci has done the same since
> >>>>> commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"),=
 as
> >>>>> have ohci-da8xx and the cdns3 wrappers.
> >>>>>
> >>>>> On Apple silicon machines the running controller is user visible:
> > Linux
> >>>>> does not enumerate a USB device attached to a Type-C port at boot
> > until
> >>>>> it is unplugged and plugged back in.
> >>>>
> >>>> boot/bootm.c bootm_final() does call dm_remove_devices_active() , is
> >>>> that not sufficient to tear the controllers down before booting Linu=
x ?
> >>>
> >>> Any idea how to test this?
> >>
> >> Add a printf() into the controller and uclass .remove/.unbind callback=
s ?
> > :)
> >
> > Ok I can try that but I'm not sure if your question covers a part that'=
s
> > been untested. What I did confirm:
> > * Stock u-boot: kernel does not pick up the USB device on boot
> > * With explicit usb stop: kernel does pick up the USB device on boot
> > * With proposed patch: kernel does pick up the USB device on boot
> >
> > Is your question related to a different scenario that has not been cove=
red
> > yet?
> boot/bootm.c bootm_final() does call dm_remove_devices_active() , that
> should be enough to shut the controller down. Why is it not enough ?

No idea. I'm barely above user level here. Trying to help with
reporting and proposing a patch based on what other drivers seems to
be doing.

> What does "the USB device" and "pick up" mean here, does the controller
> fail to enumerate devices attached to it when Linux boots ? Could the
> problem be related to some clock or some such instead ?

Sorry for the confusion here. I have a hard drive connected to the USB
hub that I want to mount at startup. It fails to enumerate when
booting using the stock u-boot but enumerates with the two solutions
posted above. Also enumerates when unplugged/plugged back.

I'm happy to help test to find the right root cause for this issue but
I'm relying on the machine for my daily use so I would appreciate as
much details as possible to the part of the code that should be
debugged so I can give you/y'all as much details in one shot.

Thanks!
-- Romain
