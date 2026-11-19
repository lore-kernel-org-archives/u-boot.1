Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C1606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SEVmyzgi;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=NhZJOwm0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15F1A60DAD;
	Thu, 19 Nov 2026 15:46:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kHgm4WkBy7yD; Thu, 19 Nov 2026 15:46:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03E6E60D96
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795103177;
	b=Rc6Uf0eF1Purjx9Xh/ntfyBm06DjxrCuY0SbuyF1fttPp74gkHu/YuHj+/zF5z3rwmzV
	 8ej7Fq+hvpflrGu179e4MyqnY6Vs4XEKgoYy5+w5plhYCiE6R8FR6W4WrzOIdUEcrKEM7
	 +QC1o7hhUmJZIish3WzNM6DRj0hiv9s9hTAnBHsytLzjV6PXjudFNjTz+dnT6h/ri2bXB
	 4GhizCM6P60kEYXGgqD+jyLGfG6BeBYE4tuoVVslmqYBz1lqNhM/M29gHF0MUUkmupZcx
	 ZdmNts02IS3gyOhQFGqnm1bkGnJfTLYYkNAAgomeM4epzf7gi/Eb638czcyv2X1qgnQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795103177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0AB+6WYPoPVHVkghJMw6vhqjmP+ipAvNEO07mn3WPsM=;
	b=L589tuq+KjuYxbyE5aJwTxvIqzM3AXbXOtQwhv14VLlXPAGxS/NVkZHye48O/QhcfX84
	 u/o6dl/tqWq6uV9hQtYr8iKEDLucyI6ZcBiVx/Po+ADHkhdEoXBttY0Zuw8tltz0B/Yhf
	 BSod8io10iYHFNeGg+pjj26/xaiRiUmaA+b82FI/av12dy+keO1Re8QVahYqXjGb3bPGz
	 lIs8g/ahaMG1IenYsg5oYysDSLJGwPPswXiMMUx4S75bRIH4xS58S+sBVuGdQwbcXUcxG
	 d7CRlKWRml483q6VMyGGpLbp8+aPmh4okGDPBCLzikJB4s0h5JnyNC+Q7qiNrECwCNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.tenstorrent.com;
	dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=NhZJOwm0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795103177;
	bh=0AB+6WYPoPVHVkghJMw6vhqjmP+ipAvNEO07mn3WPsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SEVmyzgi2kc6u7jxG57Dw3J4RmE9WdRHCbZ7xu9QTcpwJWuj3Cgg1KbRnBYIEnGco
	 rJIbzsHi3aY9/CKKUpjL1bv70s9PKhX1/FplU+uC94TA/HB2CM8XVeQ4YDefSLMlCt
	 Da2wFtGf97zIPv2usZLQYHgDzcKTRJwa7YFU3DimpBvmaTlR2R8auOJb0gflRZ0Pp7
	 UDj9sQHefTmbxEXLnBkhNsPYAf3VL2RJiBTKhYku4ap5XcmuthkB2Wtw51E8OCXynQ
	 EJrIpBNwtcze8K7enEJn47YyH1OzbwlEGYM4x1GRGwP1mLjPyujuknQ01aYt4jiceI
	 S1tNDj4RqsbqA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03E6E60D96;
	Thu, 19 Nov 2026 15:46:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F7A3465
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:46:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75F9960D96
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VH1J3a9ZPHVt for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 15:46:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DCFDF60D94
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=NhZJOwm0
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCFDF60D94
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:46:13 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b503e2a87bso20485387b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1795103172; x=1795707972;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0AB+6WYPoPVHVkghJMw6vhqjmP+ipAvNEO07mn3WPsM=;
 b=NhZJOwm0zETmmOIV9PLKgiU1aHwEAeao5ORqZAkAnALwyhDc1V0TigEFBUnD54Kzap
 UU+tV/W9t7OLkSu/6r3Gou0AN772FilVufT+Oy++qPF+zaqRFBWA69+BTTYmT6HwDEEO
 GfoAWnJdRJkjdaF3ble1PxR8Gsi9ZQyq4NwHr4c0qhOZxi37Eh3r9M6KJIteZPx71do+
 JzeeuV8KU+RGw1fUZ9GJ816zIjXriTr98cS9BZIARTe+c+HK0RNvMLmR9cLpLDwtMXZe
 z2cyH6ABZveu/APFIjIquQJMmOkYIJwdjam60EPFdFzdReYLQuGBvI5CvQoGkrMpOBRH
 Sx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795103172; x=1795707972;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0AB+6WYPoPVHVkghJMw6vhqjmP+ipAvNEO07mn3WPsM=;
 b=Kww6CF9esrQR711173rJBzlwCca9QuO7wQxqLuJP9uOnFoPMJfa4yIZhIynnDhR0Ek
 6PFmY0EnzESxd4nXgSiQZj8lVIpXjp+xTL94OgZROjaNrssW4LbC9qgXtR/MX9Y9ns5S
 KamRdCllVy3+yDMZjkNzobppEe3LBthsioVuDU5OuRAi2GcMOcEQqdY7UzCT/WahFgrA
 TZlBtpRO0CEW0zzyRI4XiT8+hJNSn6NyrN6VryqvyAazIGflTsYaKMI3zxtRSJkVQ2WZ
 LqkF/c327tdsrAMTJ1MS6/24a85w1jX0D27f9wWktJf83v+4CNcPuJ87qNwr4seZDZhr
 LiFA==
X-Forwarded-Encrypted: i=1;
 AL+hErGPhfE9OJmcffbYChXyKyhwAtHUdcysN9wIfsWMU5NtImIkdcxl6v+4ZntRCZBdsIVeJvGaPJ8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+YH01QWXmsLlq3BQ6a1C3on1rwHoNZ6O2psHMRK8RD2s7BZ5c0
 cUvQ8dFGIKcHsh9gtJgqVEP2puqTcv7Y5TWcel7x2WiRUTuEW88TcXQCxOC/w83HdQGgKLR9i4y
 wks6lMYP4MCfAof/T4+Jwws7YLRjXpaQoA92y7A1hNqtUxqRyUE7D0nI=
X-Gm-Gg: AZFdTZe1kWHnzHxPfH5uF8ugOMz9S0Or43DoDQEvNl4vneGAPz/VEn/fEO4mV7wYK/j
 99JPRC4M8sgcnObGwFNpimjf2xkYGOwh/XF3/stAdFktNd2pWdUxHYB9fho0tnmCR3phD8ovdgJ
 jSSAf/gwtjUbefbz2b8kOJoMPsvM+mKBTGSajOUN8dgC5SgHwnIbRcSdPTQ6xM4kjjeoYmn4imt
 agDlbA9tUzLh2IrTKbLozFfT92nEXB1nT9H2o9qQDZaYH8EQlQ7EIJtCy/6c3JXHp4yUNYWsCqU
 RBs6Kjb6xTcniwBPCQLNVDCMq3mfeM3HfSQQg4HhdgMGbL6kLweDl0c7Su8JiJrqaK+nQ3EXC7D
 pTfts55t7i98/GHbpfz8Wdv2KF/ntgp1RUEqoX0S9ADa7YixsdWQjC2eS6Kt8SKemlRb+9cpgn+
 q+gMERWe6RAw5n
X-Received: by 2002:a05:690c:b1b:b0:8b3:90db:a864 with SMTP id
 00721157ae682-8b520442e65mr834517b3.11.1795103172466; Thu, 19 Nov 2026
 07:46:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119-mimsic_maplic_fixup-v2-1-e29e04bf1b76@oss.tenstorrent.com>
In-Reply-To: <20261119-mimsic_maplic_fixup-v2-1-e29e04bf1b76@oss.tenstorrent.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 19 Nov 2026 09:46:01 -0600
X-Gm-Features: AclHuK89Ymb9kNeFzIVjpW3i0anHySdLDXj6JpxVn8e3b2uJrc883apnzxu7RMI
Message-ID: <CAEev2e-E2JnGF4wFyM-MEon=VUaF9KwfUVdSh6+TLLp07sbyWQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Disable M-mode IMSIC and APLIC nodes in DT
 passed to next stage in S mode
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 9:26=E2=80=AFAM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> When U-Boot is running in S mode, the DT passed to the next S mode stage
> can either be the bundled in DT U-Boot and the previous M mode stage
> use, or be loaded by U-Boot from some boot media. In the former case,
> the M mode stage can fix up the DT to disable the M-IMSIC and M-APLIC
> nodes on an AIA system (for example, OpenSBI does this fixup). These
> controllers are to be managed by M-mode software, so this is done to
> prevent S mode software from trying to probe them.
>
> This fixup doesn't happen in the latter case because U-Boot loads a
> fresh DT from boot media. Add a fdt fixup to do this similar to OpenSBI.
> This gets rid of prints like this during linux boots.
>
> [    0.000000] riscv-imsic: interrupt-controller@a0000000: no parent irqs=
 available
> [    0.000000] riscv-imsic: interrupt-controller@a0000000: failed to setu=
p state (error -22)
> [    0.000000] OF: of_irq_init: Failed to init /soc/interrupt-controller@=
a0000000 ((____ptrval____)), parent (____ptrval____)
>
> [   10.727605] platform cc000000.interrupt-controller: deferred probe pen=
ding: platform: supplier a0000000.interrupt-controller not ready
>
> Reviewed-by: E Shattow <e@freeshell.de>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
> Changes in v2:
> - Rename riscv_aia_mmode_aplic_imsic_fixup to riscv_aia_mimsic_maplic_fix=
up
> - Drop most references to OpenSBI/Linux in commit message and just use M-=
mode/s-mode software
> - Link to v1: https://patch.msgid.link/20261118-mimsic_maplic_fixup-v1-1-=
52dea8f39779@oss.tenstorrent.com

Please ignore this, I forgot to reword the commit title. I'll send a V3.
