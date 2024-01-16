Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9481EC3DA79
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 01:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B84A875A0;
	Tue, 16 Jan 2024 02:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yhvr6YfB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30E5187856; Tue, 16 Jan 2024 02:43:31 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 260A88783B
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 02:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d5c0d58909so3271575ad.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 17:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705369403; x=1705974203; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vR5Zts9CFVo9aLRB7jsYReIBBSWs4uRLDwM+x0iZO4A=;
 b=yhvr6YfBf2sgcRt7CXBfoYqijvLKbGJ8UPuipkA9D67W7b1riey3KLz0/YKfrL0saO
 aYwT5ATg8Nw+/TArGxjgWAn2ZTsTX49k5rxIwK52Z+bzwcojgIArqXbd3UK8r5B24xVQ
 FTXXF9o6Qaeb1DCb4U7fBhnkw8JsMVGtUUlJhhwawrPkrgm6uahHzDt2kJ2pXoEVXOb0
 zakHNDiCyow7epcNHjzW/EAy9XJmn5YxrC2w+VarcYVreX04qoijWSlWoCxPXiq7ki3S
 Taky+hZFCJxCbrCbvW1pw4XlAUxsU+22RDuYOpSzkLvKUqqB9r0YRC8n5z3flNbU0Rq2
 HIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705369403; x=1705974203;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vR5Zts9CFVo9aLRB7jsYReIBBSWs4uRLDwM+x0iZO4A=;
 b=OHx1AGkKTIjaLVM7Vfu+lZyGB+WIoh8IE5z4QLNT+8iPGC+fHyca2ATPwkwEX2gOWa
 +lUxylLavLoKAKv76U7xnMEStVKOfIPCicwrX9ii1vYaM0jB3H554oanGCxW38WGqv2u
 tdfZpliNNKiMm2AaLV6nrT6rO+TrUxcGee4A33uhYUutKhrnIKapcaBiSTWz0eM93uZa
 kq2Fw99AJUS6cjCsa3QzKpF3FfUjTz3TkEwbEzPoQDH34jOF/bznI8+NhStUCXsCCvcT
 xvhzD0ZEC8K59FzxJzTHYGcY/r8TPypss4GjHvTIuNuRecDXF/rhWCC+YJO3lIKLh01n
 8cOg==
X-Gm-Message-State: AOJu0YywVvF9k302LTfquxfl+qHc0UDAEUgPz/rHTSQEejCK/CS9u0VN
 Pp7smThx7SH5D32zhQlXESD8Ov7z3En1EZTWd2XHnnTIEOKiXA==
X-Google-Smtp-Source: AGHT+IEWlAJQYKZjoxltdKFAvo+gGMRaq/X/0TIfDKTLQmM2sHN7Uo44lC/WkeVi5xalHNeR9glQbw==
X-Received: by 2002:a17:902:a50b:b0:1d5:bcc2:2bac with SMTP id
 s11-20020a170902a50b00b001d5bcc22bacmr8384981plq.1.1705369402896; 
 Mon, 15 Jan 2024 17:43:22 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:eb20:38d8:5fc5:1d49])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a170902d4cc00b001d4e04b4938sm8195788plg.85.2024.01.15.17.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 17:43:22 -0800 (PST)
Date: Tue, 16 Jan 2024 10:43:19 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Message-ID: <ZaXfNy2V8y0N1o08@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org
References: <20240110011637.174710-1-takahiro.akashi@linaro.org>
 <20240110011637.174710-3-takahiro.akashi@linaro.org>
 <1c42a17d-1043-4449-93c2-9020c1ded71d@gmx.de>
 <ZaSDUrTQ2Z5N+gil@octopus>
 <d70d5134-1cc9-4d56-9aa3-499ed992584c@gmx.de>
 <ZaUFH3r9MdW+tHTv@octopus>
 <379beb70-c147-470d-ac45-ecc8c93a5f52@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <379beb70-c147-470d-ac45-ecc8c93a5f52@gmx.de>
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

On Mon, Jan 15, 2024 at 03:16:22PM +0100, Heinrich Schuchardt wrote:
> On 15.01.24 11:12, AKASHI Takahiro wrote:
> > On Mon, Jan 15, 2024 at 09:34:51AM +0100, Heinrich Schuchardt wrote:
> > > On 1/15/24 01:58, AKASHI Takahiro wrote:
> > > > On Sun, Jan 14, 2024 at 01:46:45PM +0100, Heinrich Schuchardt wrote:
> > > > > On 1/10/24 02:16, AKASHI Takahiro wrote:
> > > > > > At this point, EFI boot manager interfaces is fully independent from
> > > > > > bootefi command. So just rename the configuration parameter.
> > > > > > 
> > > > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > 
> > > > > This patch breaks the 'bootefi hello' command in
> > > > > qemu-riscv64_smode_defconfig and other QEMU defconfigs.
> > > > 
> > > > What happened? Please elaborate details so that I can trace your issue.
> > > > 
> > > > On my side, I didn't see any problem with "bootefi hello" on qemu-arm64
> > > > and moreover CI check (github pull request) didn't complain anything.
> > > 
> > > The failures are logged in
> > > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19302
> > 
> > In the logs for qemu-arm64, qemu-risc64 and maybe others as well,
> > I see the same error:
> > --- ---
> > ______________________________ test_efi_grub_net _______________________________
> > test/py/tests/test_efi_loader.py:188: in test_efi_grub_net
> >      addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
> > test/py/tests/test_efi_loader.py:136: in fetch_tftp_file
> >      assert expected_text in output
> > E   assert 'Bytes transferred = 520192' in "*** ERROR: `serverip' not set"
> > --- ---
> > 
> > This seems to be the root cause and my commit will have nothing to do
> > with the problem.
> > Please check the test environment.
> 
> You are looking at test_efi_grub_net. I referred to 'bootefi hello',
> i.e. test_efi_helloworld_builtin:
> 
> 
> ----------------------------- Captured stdout call
> -----------------------------
> => bootefi hello
> 
> =>
> 
> 
> The command does not provide any output.

Ah, yeah, but

> Best regards
> 
> Heinrich
> 
> 
> > 
> > -Takahiro Akashi
> > 
> > > I have pushed the tag failed_20240114 to
> > > https://source.denx.de/u-boot/custodians/u-boot-efi.git for analysis.

While I compiled this code and tried to run "bootefi hello",
I could not reproduce this issue, always seeing the right output
either on qemu-arm64 or sandbox64.
(I also invoked test_efi_loader/efi_helloworld_builtin locally,
but the test passed.)
So no clue.

-Takahiro Akashi


> > > Best regards
> > > 
> > > Heinrich
> 
