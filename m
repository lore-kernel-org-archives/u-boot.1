Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93878C47077
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 00:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C902F8753E;
	Wed, 17 Jan 2024 01:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mP7z+57q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5488D87559; Wed, 17 Jan 2024 01:40:36 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F498753E
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 01:40:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d48a8ed85bso25407125ad.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 16:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705452032; x=1706056832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Nvdd2iRaHS3P64zC7pmDYRMjJAbM11guYkeIIkOPdU=;
 b=mP7z+57qIYeglF1FCgpz9NqBHb2/BRknf2Q1eO9z9JoabgG4xn284yKMR4rPvX61rK
 uVWoELSxPalsUrlFZR7cfLNje7FtSAFDPW5d8xabwcS6eleAsIS5QyLZG5FyYpr02ZIU
 7RysjdcyDgaeGax2o5BYBQFW0n4Ymk6hXzhIBnZUeGjYlJZ1p5t2+v2YlLbTglVxBAgL
 pONtLLb5K5pDy7hLi2UzdJ+t4VGhKhh3/nE0sn8fljQg4I871Hlny/tzjSVWCBJj7bn8
 GxliAOuFSujmYU9qOtjeZ2Z9EvxeNbnroj3AY4E2/UB1PLGDJzshghIUoZGVavcRmLvI
 iT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705452032; x=1706056832;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Nvdd2iRaHS3P64zC7pmDYRMjJAbM11guYkeIIkOPdU=;
 b=woDP4cVTZFX8dXiRJr3qC/PMWqEwoayBVYpA2X+MeF/Jqzf/b7LQdlPj/0AcaXtRIU
 bTqCoTxQGjOjLNFptAnxyJR29Y0Yj7zSrwMF9zwzRtt7z0y7VFY/pA2zSNDR1ZgSQbQX
 67FUwrALvGll7xt6jsDmINrEY8a9Pjs4ujI4OHy3wZ1FeTBd1s3iCZgNRrOea0qqFzlh
 k3NJZmPhgBmAskuosKocfRkyVB5hfS70xnGoXX6HMdw2oIuKXbVBkZ8LiKw3BIFcMJR+
 sg+llk+p+SqfndTnmhFeQFQQMauJI9XzUnL5YMR7k7DITyTyP5ZmT6kNp8cw+YMGACox
 vm9A==
X-Gm-Message-State: AOJu0YwIgRK6Vg/DtUNq1pSHDr81yfSadWMGetZlBIZifYT72OttWLUy
 2XxXHgUblhbt/Vq5zR0anixj7shCmk1OzA==
X-Google-Smtp-Source: AGHT+IGZwxqD1BYXtBqUVts4OEeGGdYArqeSPiusrja0btRLxBx6HtxcmVM5i4hSZe/x9ecZaW7cUA==
X-Received: by 2002:a17:902:d50e:b0:1d4:e2bc:891c with SMTP id
 b14-20020a170902d50e00b001d4e2bc891cmr15600889plg.5.1705452031518; 
 Tue, 16 Jan 2024 16:40:31 -0800 (PST)
Received: from octopus ([2400:4050:c3e1:100:e481:26af:1a49:433a])
 by smtp.gmail.com with ESMTPSA id
 lo13-20020a170903434d00b001d3a371cd24sm9939714plb.53.2024.01.16.16.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 16:40:31 -0800 (PST)
Date: Wed, 17 Jan 2024 09:40:28 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v4 2/4] efi_loader: rename BOOTEFI_BOOTMGR to EFI_BOOTMGR
Message-ID: <Zach/J8WDx23Yz2K@octopus>
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
 <ZaXfNy2V8y0N1o08@octopus>
 <ddc1e7d2-c70d-4a7d-884a-6a18db3ea1c5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc1e7d2-c70d-4a7d-884a-6a18db3ea1c5@gmx.de>
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

On Tue, Jan 16, 2024 at 07:44:22PM +0100, Heinrich Schuchardt wrote:
> On 1/16/24 02:43, AKASHI Takahiro wrote:
> > On Mon, Jan 15, 2024 at 03:16:22PM +0100, Heinrich Schuchardt wrote:
> > > On 15.01.24 11:12, AKASHI Takahiro wrote:
> > > > On Mon, Jan 15, 2024 at 09:34:51AM +0100, Heinrich Schuchardt wrote:
> > > > > On 1/15/24 01:58, AKASHI Takahiro wrote:
> > > > > > On Sun, Jan 14, 2024 at 01:46:45PM +0100, Heinrich Schuchardt wrote:
> > > > > > > On 1/10/24 02:16, AKASHI Takahiro wrote:
> > > > > > > > At this point, EFI boot manager interfaces is fully independent from
> > > > > > > > bootefi command. So just rename the configuration parameter.
> > > > > > > > 
> > > > > > > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > > > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > > > > 
> > > > > > > This patch breaks the 'bootefi hello' command in
> > > > > > > qemu-riscv64_smode_defconfig and other QEMU defconfigs.
> > > > > > 
> > > > > > What happened? Please elaborate details so that I can trace your issue.
> > > > > > 
> > > > > > On my side, I didn't see any problem with "bootefi hello" on qemu-arm64
> > > > > > and moreover CI check (github pull request) didn't complain anything.
> > > > > 
> > > > > The failures are logged in
> > > > > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19302
> > > > 
> > > > In the logs for qemu-arm64, qemu-risc64 and maybe others as well,
> > > > I see the same error:
> > > > --- ---
> > > > ______________________________ test_efi_grub_net _______________________________
> > > > test/py/tests/test_efi_loader.py:188: in test_efi_grub_net
> > > >       addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
> > > > test/py/tests/test_efi_loader.py:136: in fetch_tftp_file
> > > >       assert expected_text in output
> > > > E   assert 'Bytes transferred = 520192' in "*** ERROR: `serverip' not set"
> > > > --- ---
> > > > 
> > > > This seems to be the root cause and my commit will have nothing to do
> > > > with the problem.
> > > > Please check the test environment.
> > > 
> > > You are looking at test_efi_grub_net. I referred to 'bootefi hello',
> > > i.e. test_efi_helloworld_builtin:
> > > 
> > > 
> > > ----------------------------- Captured stdout call
> > > -----------------------------
> > > => bootefi hello
> > > 
> > > =>
> > > 
> > > 
> > > The command does not provide any output.
> > 
> > Ah, yeah, but
> > 
> > > > 
> > > > -Takahiro Akashi
> > > > 
> > > > > I have pushed the tag failed_20240114 to
> > > > > https://source.denx.de/u-boot/custodians/u-boot-efi.git for analysis.
> > 
> > While I compiled this code and tried to run "bootefi hello",
> > I could not reproduce this issue, always seeing the right output
> > either on qemu-arm64 or sandbox64.
> > (I also invoked test_efi_loader/efi_helloworld_builtin locally,
> > but the test passed.)
> > So no clue.
> 
> Please, rebase your patch set upon origin/master and retry the tests.

After rebasing my commits to the latest master (please note that my v4 has
already been rebased on the master at my submission time), I tried the test
again but anyhow the test passed as before on my side.
I'm not able to reproduce your issue.

The only conflicting commit was f19171c919e0 ("efi_loader: Clean up
efi_dp_append and efi_dp_concat"). I don't think that it would make
any difference.

-Takahiro Akashi


> Best regards
> 
> Heinrich
> 
