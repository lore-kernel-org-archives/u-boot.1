Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380E5C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA0086A1F;
	Tue, 15 Aug 2023 00:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cBDXBNNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FD3E86A1A; Tue, 15 Aug 2023 00:43:53 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237A986A19
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d62ae3fc7f1so3635922276.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=taBPzOUG28vtRZAzSBz27EWq7V9wo2h2j9ykntOjvk0=;
 b=cBDXBNNWIxy21CC9+e/trzpW7YtxT4gXc2BdDAtvxgg0B6hAv6b9AUrgthDSua39HZ
 +ZFi0KG2vaBBzHRacGyoAfmbtodMCJnFUQP9DXufYpT2vzXoehTTATalEZAbTARpO4SZ
 MKAquErJOm8uH+jpKkRLLr3UrCEoV4usppMAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053027; x=1692657827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=taBPzOUG28vtRZAzSBz27EWq7V9wo2h2j9ykntOjvk0=;
 b=iGSF81LEBBmnh7+T3ltLHUR3OPqdF0YqcoIAAe/f54TlpFufiUt11DhvVXPa2BZCCf
 Lnvol7sIIkt14i+2joq+WdHkwgnPIDKYugOILv0qVpALiYaVdza7g0hS81LRr0m96D1c
 nDS0WGBeQCad5V1FkUIrLLbgcINgcuoLNcvi6vQ788jivFiOLzlv95lSMettBQEeKEya
 8wF7KHN6fJlEtX2/a7+TleyxPYEPPqcIwpK9Nb/QazIKqp7F+cHH6Ky9lW3RDN3ft6rX
 4O1QVgrI5lRLAcYgXRtKIx8/WU3PN1LNhne96SUt7oaT8gASCYkE0ekwwBrAI8jhHQWB
 N92A==
X-Gm-Message-State: AOJu0Yzj4QMHbNkyM1kYNxINZsWgx8lXkUgtZdgZbfJi6ARd0+Zh6o79
 ezfhX2OIR/JXtw0Rf47SI6GgGLFF2FcWrmPaXi+nfs29foVhqQJ8rvE=
X-Google-Smtp-Source: AGHT+IHD4jKIJRjuI0ynNxfoXzgNUL40vMJkit6iHy7p5A8G1ZgqocNJylEGWhEt5cuaSRUokn2jSKfniCDtfKc1yaM=
X-Received: by 2002:a25:c0d2:0:b0:d3b:e659:5331 with SMTP id
 c201-20020a25c0d2000000b00d3be6595331mr8631513ybf.58.1692053026620; Mon, 14
 Aug 2023 15:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
 <20230814173944.288356-5-alpernebiyasak@gmail.com>
In-Reply-To: <20230814173944.288356-5-alpernebiyasak@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:43:04 -0600
Message-ID: <CAPnjgZ2d1mJp28UP2+zKC6+2pED_=YdovA_jaNJz2r+C=-jufg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: qemu: arm: Add a section on booting Linux
 distros
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng@tinylab.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, 
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Alper,

On Mon, 14 Aug 2023 at 11:40, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> Add an example qemu-system-aarch64 command that can make U-Boot on QEMU
> boot into the Debian Installer, along with resulting console messages
> from U-Boot, based on the existing documentation section for the x86
> version.
>
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
> I actually want to put the root.img device first so that the VM can boot
> into the installed system when it reboots, but U-Boot can't find the
> bootflow on the second drive. I tried e.g. `bootdev list -p; bootflow
> scan -lab`, but it seems to only ever search the first virtio-blk.
> However, `eficonfig; bootefi bootmgr` makes it boot somehow.

Yes, this is annoying.

The problem is that the scanning is getting so complicated. The
boot_targets var lists things which can either be a uclass, or a
uclass with a device number. The currently implementation sees
"virtio" and moves on to the next thing in boot_targets once it has
processed one virtio device. That is obviously not correct, but...

Would it be possible to just drop the 'boot_targets' var? That is what
is stuffing it up, but we don't actually need it now. The defaults end
up doing the same thing, apart (perhaps) from the strangeness of
virtio which can be both a network and a blk device.

I believe it is possible to do the right thing, but I'll need to
create a better test mechanism to handle all the cases.

>
> Changes in v2:
> - Add new patch for doc section on booting Linux distros
>
>  doc/board/emulation/qemu-arm.rst | 68 ++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>

Regards,
Simon
