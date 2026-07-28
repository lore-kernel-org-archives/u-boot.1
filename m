Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB67C531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:29:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F3193607ED;
	Tue, 28 Jul 2026 11:29:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DAFMPQdAUU_C; Tue, 28 Jul 2026 11:29:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CB3E607B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785238143;
	bh=BfEvMxFRdvN/LhUi16e30Jb1eugofXzq8fU3xq/n9uU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QS77mOK9AGvOD546aK1h9ZEDKDsqdAuIu6yo6ElUuW0DsHsHRUWulxPjGTXJe4dui
	 VRxyRakYnrXTyYQpQDjBnpRdUk+YgW6IMe9qwlkVkHzOswlBISoFyNBIe7cBITk7zU
	 UnTuRlgwh5jozfKismSXm4tQZYlcwNmh9r/T8lxPkVy5P+aA7ExU8nSO2Au1O0PjZJ
	 qHjuoeAAQMEp0DvOz9UnrQ6vD7EWMKtu/uB9HUlOcJSApWjOxFubD74e3ywUlX+8EW
	 Tilo2Z4k6f5ZGZ1U51FTdbMnL81+WwuJW1qryAeuY7fszOSOCkG+PSVovC10lNYrg6
	 /LvnEoD36zwsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CB3E607B6;
	Tue, 28 Jul 2026 11:29:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B954350
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DAE9810CB
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:29:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tm-_HOsLflEV for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:29:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E9AE2810B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9AE2810B0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E9AE2810B0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:28:59 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B25E8494B; Tue, 28 Jul 2026 13:28:58 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6AD2848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:28:55 +0200 (CEST)
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2caed617615so38351815ad.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238134; cv=none;
 d=google.com; s=arc-20260327;
 b=oIhc1hxcd7a9UoiYzLsg5BmA/ap92Ml3w5lUO0awTcO+6JqxRbHVa7WCKhteDWrGdS
 iQoHHAYwJ7Duet7YjvU4mJXFuHBG9fvFmFdpUy3PDDHz6We6Jz9PQJd3amoOsrlKJGwo
 KZ2y04kCtqMPa7wWEeko/MfftUZVBl0WmmrA5cKHgKdgXTKoJuvISibS6z97OLO3lKvI
 yhEpCs5v6RHcbqQTjnfmwEdJr5v81qxYvbV/vBecKe5z/n8LhePZ0lKgo6/HgI58+gtO
 vOHS5jWLvnGTPQ/DipcEI6RqNTRA4/XnglL0gn+EGWLjTe1PGivHE2SdKLgk6KwKuidj
 e0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BfEvMxFRdvN/LhUi16e30Jb1eugofXzq8fU3xq/n9uU=;
 fh=rLQMN6a/UX9jMmUsQuTe1A8wK9bTo6tPxTHfkaExRTU=;
 b=SXjwDKSWfxZZ1r46ZkIGLxDgtinbVlQ44CON12sbvGi9qxnVL8iv6YBUs6+UHrc1ud
 kIcbv6D502Qhu0efVQaZ2hk28i2I9KwJsIjGlU1LG1t0sbBdyUO5/eXE5J1b7E0h954d
 31ACslCxaMaC3h5mTXK6ctXxAxbt92MQLF+xCcINaO8CJ8HJ8Niztw4SL2h3Egira86g
 cnfGExW5xflGqKC1us0TSvzpV2qCFrtFkE3s/x5XayJNsPUqcHwAC0642fJr0nUrh0In
 RJj9LcHjxmftqSh8XXN85XdJlh9+YEB1uz2ZGLwCI62cotmUSxx9oeQx8Ode26telKqm
 75Mw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785238134; x=1785842934;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BfEvMxFRdvN/LhUi16e30Jb1eugofXzq8fU3xq/n9uU=;
 b=HhDocnkFUA+pe6D9mrL2sbsgHi1blsDXxuFkJXXZ/kxC43mQoyEHR5o2rbjhkwekgm
 I27WBlTsur2ZiVMQeePbFSEIhaZ3T0dHe7nAg4r4lNl1JJWtp1HwGb+GyZDoYgAsermA
 RqInzHvSlyzdvJ5nikjn++ALQ7rME9R9N+BjdG6EaI0vW6Qwn0CaCWCuOgNMgo2naoSZ
 3DGzaZFyVVbKgDLqcNIxv9W+xZwxts2IVvMnRO8tsn1jGhh2pntJ0xc2so7AqZR5GBmV
 6cebV+pPZ1fuBA4AIDfbmiOKCztoSjOVDe0elhmE6PuM06SbfxNIOUzPjO1GTbktPcvK
 wALw==
X-Gm-Message-State: AOJu0Yx125iINiDYUaExeTaiX+/oAeKj8V9VgpF3xpOLuawuecZ61fhC
 juND1rQ8IizgpvGSHqLTqYS1juyL9spm5egkrKlLFJLyf0p65ect/X/b5gGMwC9PrHmVH5ZxMq+
 zaREl9h5/Vh0vvqVrXdR7lqJW2rPtF/cAE0crufE3HTtOjQaKPU4=
X-Gm-Gg: AR+sD11LDNRWeYWKzGeFSaPviEyMYo9/rHLaiZ9+hg/FaKs4ms/KGLVbVq+8ZlthT0L
 m6ODc3V/WNPo+rxjVfkQ9E68y51l1PYBQ72PvT9fxAcFvBfTAMzKqrELdA/Cf0PLIsc1ExneocA
 dZ7wMdopbhfIuvh0gVIeuBroNiW/5Y3X8SUFm4zqQ4ioo1cLosDFu9BoBVPJXVwxiqEoEiZR95s
 zZ+i4NSNAHlXLa13D1fhqqR7mW/1jTxHjbEx3q2wUsFhT8JywB6UoDb9V11
X-Received: by 2002:a17:903:230f:b0:2cc:89ce:2ef8 with SMTP id
 d9443c01a7336-2d015d983b3mr25553455ad.40.1785238133862; Tue, 28 Jul 2026
 04:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260716223401.378989-1-dmukhin@ford.com>
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:28:38 -0600
X-Gm-Features: AUfX_mxQaY0MzM2nbVb9_dko4S_qhdWvPFC8RJfQl_zfkU5FP95NsuSR0q4926I
Message-ID: <CAFLszTgHapV2k8S_2wPgGDowontyhaaRUj9bKRCgEvqKQfN8CA@mail.gmail.com>
Subject: Re: [v3,0/7] few fixes for NVMe and block devices
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785238134; x=1785842934; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BfEvMxFRdvN/LhUi16e30Jb1eugofXzq8fU3xq/n9uU=;
 b=c1V3dUOd6FvcLC3ZsqTdOGCP2mm3nVAJ5inbmwDaLLLsX95nmSikUvR2K16Q7U0BAG
 Rw8F5NPwuBkB+SzcbBp6cwFfnUn7w/Uq153NXrk8/t4Toy72MJ5yBepwc+/KMffVxsFy
 +1/o4khLGYFIAGB3mggG3ST0kN7pO49DP/v6Q=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=c1V3dUOd
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="c1V3dUOd";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Denis,

On 2026-07-16T22:33:54, None <dmukhin@ford.com> wrote:

> The series adds few fixes for NVMe subsystem and block device management.

This is really a new feature (block-device flush support) rather than
a set of fixes, so please can you describe it as such? It would also
help to explain the motivation in the cover letter, e.g. the OS
hand-off / power-loss scenario you mention in patch 1.

The new flush subcommand in patch 4 is user-visible, but I don't see
any doc update for it. Since you are adding a new feature you may need
to update the command documentation as well.

Regards,
Simon
