Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30022EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 00:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EF688D22;
	Thu, 12 Sep 2024 02:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dg5fooYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D185588A43; Thu, 12 Sep 2024 02:58:38 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DFDE88D27
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7d4fa972cbeso343682a12.2
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102713; x=1726707513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nk7R+m6I0bROejBwC2YOsm/RplRf4P5v38wrr4ptOQw=;
 b=Dg5fooYi0nx53yUYdzAmf1egMNaxOYeRXORvPT9P1sy9R95h+PEs/m01Z4KceVoCkM
 72nyJJoWlQpLBd0ecEzVuGHdqJ6KA0B8DgV3Otu1YVra7nLvOExt8NaHAF3r8by2rxw9
 CIsEbLo4QKmvGSujZGTg4ZUJLiCS6zu3Hhf24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102713; x=1726707513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nk7R+m6I0bROejBwC2YOsm/RplRf4P5v38wrr4ptOQw=;
 b=cHY2x1egPoexNvV+05N7JfTyX0wzzhmM7AshkOeS78R+RB+qALqIrkwEZGRHq6PwoO
 xeUji+9GRP967tFfT0v5YzKO6MT5787hsYZljUONzfF2u9Z92N7Rd4AvtoEhGaaahlIy
 /nu2/bhIerLCbBOTZZHSr9gW/U6Y0gqWGqHWo4bPt9uFKBtqxGKH/IrRMN2IzWs3/hHG
 3p6j1zM1Hc4Fzl/sy2GmAw/hgaISFX5rxn82BNmDX+qT+eCMDSp/VXVm2G6uK23XEv4o
 5fYph4AnZ8otWhOowJ7XO9kU8Ubsp3hAXd5XQn5sb9LLzxYWFNXN4NxFaqjU1MxKD70E
 QWYw==
X-Gm-Message-State: AOJu0Yxcd5J5+PR7T131SeDhUF1do0wI8Y13zJQfMqdr8Nj0BCDQKeID
 1SpufnILEXDspGqnkKw/tJNJCh8aMD0KodVGbLrTclmmSMQFSI86Q2zJPufsknEl9RCfaqj7gxb
 UXArzng4C/oFUDhevYAdw9NYGRPWoTUxa6F+ty48V5Yb0rHE=
X-Google-Smtp-Source: AGHT+IHabDEkdhkrdbhJdxSNwVh23IKd9ENMk9meq0yNAcPI+dbs5AslO/MhUlRlE6CoE6qAVoyYS8nRz2cna6Gi6h8=
X-Received: by 2002:a05:6a20:db0c:b0:1cf:314d:4ff5 with SMTP id
 adf61e73a8af0-1cf75c7ed03mr1284727637.4.1726102712871; Wed, 11 Sep 2024
 17:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-16-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-16-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:21 -0600
Message-ID: <CAFLszThZGG-mojri4gWGmTvzL4TC1EBH6YfCFwQ-fKerdoYPAQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/30] acpi: Add processor device
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Add a new method to write the processor device identified by _HID
> ACPI0007, that is preferred over the Processor OpCode since ACPI 6.0.
>
> Fixes booting arm using ACPI only since the Processor OpCode isn't
> found valid by the Linux kernel.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  include/acpi/acpigen.h | 12 ++++++++++++
>  lib/acpi/acpigen.c     | 11 +++++++++++
>  2 files changed, 23 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
