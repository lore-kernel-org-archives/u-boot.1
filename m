Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F84CAC5A5
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 18:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B67A8341C;
	Tue, 23 Sep 2025 20:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="arKk2Yhe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2FAE80107; Tue, 23 Sep 2025 20:40:39 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A384833E9
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 20:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-b2ee3c13aa4so285601866b.3
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758652836; x=1759257636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EsU4SzD5QnwoSQ6a9BnPJ65QUAWIJ7OX+h+m6YKczpE=;
 b=arKk2YheTDBmrRwvelfJTJHk8/3ggnyQ5CLZOcgap8aB7rByue4ncmwhjA9/BjKFbU
 CPYhZg8T0q6D852xRjT00/SS3YDc8ulFUQOFiehoHTCu0EMLzZt6k3Wj8l3PKFxdngpI
 Ypbwe6ZfySZyKHUUoIx4NHBqVqwH3xM+e1zhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758652836; x=1759257636;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EsU4SzD5QnwoSQ6a9BnPJ65QUAWIJ7OX+h+m6YKczpE=;
 b=eEMZlaUCmhC1eXx5MK94jI/BOx/FiR2b7eFx6gxv4ArCPR8BF2hrNv9OYRWs5FHXV1
 o9i4HZ/jzG6ho4zQmedmtmpX9q8kC8nxDU6RMphZXgKFDxxBx08C6JnE2pmYVa/lZ2qd
 veyev8T5uj9yV1kNOfWeLrPBqRcmxVJxcnqLFJms+Os0nFtCYxLLTsKkwOfNOaMv3XWC
 NJmhevBlZFVnfkba6TtGSRbPsCbG+1tCSyjtBx8tAdCD0tZLeC2ISoXwzKRuaf44p3PG
 XsKqX0a1LvdBetoOgOXgtzMX+cRrz1gR0mGKXGIGZ6mFrv9KtHSiiNvKk/uYAClJ8tzl
 gLqw==
X-Gm-Message-State: AOJu0Yz78Ex/+kPIArPq1YsAMBS7mmsdqlS1DINChPFn2iSPAXhVTLB/
 SFiLFPm9kxMmv5IqzOnWQNcyNJDhEdgGSOCE/IUb8PnstBnnGw+6dl4PJeyeoKY+Ws/wyrNfOY2
 CU0TKwazGmL6MrzKsT+Bw9lz5gVGodHASB4U172L+jy+GQCSIpIxlzu1p
X-Gm-Gg: ASbGnctMSY0plkF/KolAeASn/oOZdV74dXkf+LewhV97yKxa9EvgQ7iS5sVuUhQfNuL
 mgYMC985Hi1+7OcAUPh1k11LJuTXYf2M/ZC40eCIqijW+pnhbc9ImUVT5Osxuz6UsCYxNs3n006
 0Q2QoykXNwqsPzvbfAw4z2kZ9pxxepPIyw8i88GUq9tyeGWiX9Et9vnBYbyLhwIP7iEOdi0NYcs
 qD2IQMNyDAMGAlC
X-Google-Smtp-Source: AGHT+IGrKX8PNd17B6Bl9GCFPweBFYcoXohJ58kXqL4faObuKgSN+2FdpIQ562fWOqJsrQPLnhcZtJeCi3MWDLe2TXs=
X-Received: by 2002:a17:907:2da6:b0:af9:eace:8a52 with SMTP id
 a640c23a62f3a-b302ba11b03mr367003466b.50.1758652836147; Tue, 23 Sep 2025
 11:40:36 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Sep 2025 12:40:24 -0600
X-Gm-Features: AS18NWCWs33Ws4UOZ1U67RcsIC-dBNRpdd6g3ycKrPFDK6wfFCSQYJLdogIluCg
Message-ID: <CAFLszTjH6-dQxy-wgGR5n_7eqhnLQk=N=XVYvBr_n0NvN7=U_Q@mail.gmail.com>
Subject: Reviewers please for Flat Image Tree (FIT) Spec
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: U-Boot Custodians <u-boot-custodians@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

This spec <https://fitspec.osfw.foundation/> is undergoing another round of
changes, but since it is now hosted outside U-Boot there are not too many
people seeing the PRs.

If you have an interest in FIT, please can you take a look at the PRs
<https://github.com/open-source-firmware/flat-image-tree/pulls> and ideally
send me your github handle so I can add you to the project as a reviewer.

Thanks,
Simon
