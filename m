Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37C5C83F10
	for <u-boot@archiver.kernel.org>; Sun, 27 Aug 2023 15:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4CEC805C8;
	Sun, 27 Aug 2023 17:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWFAyQYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A7386308; Sun, 27 Aug 2023 17:49:48 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C59A1805C8
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 17:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso22235925e9.1
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 08:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693151385; x=1693756185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LfIBZ102vF/LeLR9xapeu0JnFhVfvZp7mAKkvlW/4I0=;
 b=MWFAyQYALF/Pprt/w/PGJijHvDLDDIpF/WrWajNKJx+Ii4J3CS9a+vHJmZpRQai5wv
 UsAkk4cuqRCdNyL98en8nB4dzryWYFDKEXkP+b8xSF4TMdYAjfvEgbdzLsCyqWGW5Ogk
 BCxowSXX7wgM4aaBgUD3LI2ewArkeQAYMTFEtn5L0G0CV6C/EmnRGg4w1DAyT/3D6SQm
 nJpLwTrnTuNYo8xuB9/13nZmc5yGMmQCHHB/ngvOc3tRvmDzBi6QXuxNeTCgGLr8Ngpd
 B6SJQ/PhymxwDaF+grRYQVGJoRhsn/u+S3esD7cXf2syPzxQS9jYsHyVtuIWr/qGlpLE
 J9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693151385; x=1693756185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LfIBZ102vF/LeLR9xapeu0JnFhVfvZp7mAKkvlW/4I0=;
 b=bA2+W0NuMquVE5zSosSJ6lvTohnq0OHg9irFEn5p+cuSOUMhqC7TSSQcz31tvxAOsD
 cguESlmsnX/RMSiOenXYXpymZUb84zylA9OMcjey4UJr+KWGvBpa2zUnMLpSsxPqkJZI
 2PU5h1lIY3vfyLBV9euq9oTezfVTGS2E5OnEMuj8s/zdN5qx7rMIEgSsuFlO9n5gIGzJ
 dZV90WMhCrKUExPoa8w2SWUfUmeNkQzg+fN/szoBKdE4i/W2w++nP2qn5r7lFimZXmeJ
 0N27cXO0XC2IOZ+eDbh38iG5cGE8ecaUOTrpiFQQqZhxtygVkkyJxz+CTHGElZNvZL8l
 v7dw==
X-Gm-Message-State: AOJu0YwDlg9sxoePY4p/EDQ+ygJ/R1Ls2d8EQDSIBjC1zmVRsccHevz3
 TfkrmFrtfC6h381qvfaayfU=
X-Google-Smtp-Source: AGHT+IF6GvINrOMzLVPPKq1g6luN68r7Dw2aPZbQNIlA1TE8KcCCP6WZ4dV9bqjefL1ZxmHwXKni/g==
X-Received: by 2002:a7b:c009:0:b0:3fe:1cac:37d7 with SMTP id
 c9-20020a7bc009000000b003fe1cac37d7mr17339020wmb.10.1693151384860; 
 Sun, 27 Aug 2023 08:49:44 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 2-20020a05600c248200b003fee567235bsm11003667wms.1.2023.08.27.08.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Aug 2023 08:49:44 -0700 (PDT)
Message-ID: <8add4068-7b05-4f32-8eb7-31366fb396b9@gmail.com>
Date: Sun, 27 Aug 2023 18:49:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] doc: qemu: arm: Add a section on booting Linux
 distros
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng@tinylab.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
 <20230814173944.288356-5-alpernebiyasak@gmail.com>
 <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2023-08-15 01:43 +03:00, Simon Glass wrote:
> Hi Alper,
> 
> On Mon, 14 Aug 2023 at 11:40, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>> I actually want to put the root.img device first so that the VM can boot
>> into the installed system when it reboots, but U-Boot can't find the
>> bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
>> scan -lab`, but it seems to only ever search the first virtio-blk.
>> However, `eficonfig; bootefi bootmgr` makes it boot somehow.
> 
> Yes, this is annoying.
> 
> The problem is that the scanning is getting so complicated. The
> boot_targets var lists things which can either be a uclass, or a
> uclass with a device number. The currently implementation sees
> "virtio" and moves on to the next thing in boot_targets once it has
> processed one virtio device. That is obviously not correct, but...
> 
> Would it be possible to just drop the 'boot_targets' var? That is what
> is stuffing it up, but we don't actually need it now. The defaults end
> up doing the same thing, apart (perhaps) from the strangeness of
> virtio which can be both a network and a blk device.
> 
> I believe it is possible to do the right thing, but I'll need to
> create a better test mechanism to handle all the cases.

I think some kind of a "priority score" could help -- iterate over
boot_targets first just to generate bootdev priorities, then carry them
over as bootflows are discovered (adjusted for bootmeth order), then use
those scores as the order to boot / to show a sorted menu / to test?
