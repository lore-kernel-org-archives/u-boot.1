Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE908606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dRSu00Wt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eu3TNhTX
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C664405F1;
	Mon, 16 Nov 2026 10:40:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BDXTIRl188vX; Mon, 16 Nov 2026 10:40:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 66688405D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794825628;
	b=NOGQK8O08T5g3x5JEKxj94/lqRjHYKvMwknio2xaaJl+XSF3B3uXeyP8Z3oWSEoXGP7V
	 8H9xQx5xBTRt9WgIkWauFhbFMyHLwf9gHhmHtRFu/vnJi4X3xqJkEhwXENvbNItkeLeOr
	 aiRoKr3Xx4jeYHQVOrxMgBfWvOndnWHLWBzrPBjh8UW1hbPQqBByhP5WeALpnpY/1Pf7d
	 oMLq8P9yoDCQg1ePDGR0PAPbmKZiQEYfxQ/IgUPX6lMmd7OkTWT4R1EnMArmakEeOfn05
	 oU7OXgkb/yB4snAwefRofVDn9oOQz8VZo8oYbN92gTM/UzcQMDVn4l5WGMLOXdfc7Vw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794825628;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pG0p61DmGim8TIRru+2cHTsNX2BkrFrrGNkEnuOzjzU=;
	b=iSQ9oiVAGGCt5UHEgWPrUGscAWyyjDzjWg83zGd62iD5zXO/3Kp1bicRrYnSEXv9kUNO
	 SUPS4Y6nqs91YWw+cEIUdtdpt+AAFriyUTp1HYZf+U5NOu9nQDQ75cGeOwtBKah3KAu6p
	 xq+eumknM96gBezpUQWNmi8LF8TxPKbkBRD4Zlo8SIwdljOwYUKHCFd/4tFGuSq/8tYbt
	 pQC/wDF6VgPU/WlgUm+18/AafOMjiBwcuC16KbjKtRtvXImzS+/ArdDR+oT0M6I1xK7Bn
	 Z2A2vMkuhlMgxUg/cmvwsEbWjMj+erMCtQzVs/qZqZs2oLlDiLxH6OgSRQ5IIkIwgdw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794825628;
	bh=pG0p61DmGim8TIRru+2cHTsNX2BkrFrrGNkEnuOzjzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dRSu00WtyOWssX+Szggx/cvDRoGOxbzzjur8273oZeHWlmGcbtCiu/soon2+sAaTQ
	 RcGHsbPPfKJrodSomDtXv4JbIFYmUdKctjD2zLyPih63p26XgeeNgprUQR/rK1SCd9
	 +xEzUH5ZqV6zg521jZlObdWK2Lh6nnfepriVxkqWZU4drVfLcwBIAny1MnBNct7PVx
	 KK1c3Dz6+XxVCkklTnGChrGTzqoZCReqEWHyK2H45x6OqyjTQaB7xa3kKyXp6DBZX4
	 qBd8a6csS7fo4ookZDABc2aCEa3zxYV5QlnbWlqgqeQgqx05CSxjYDCkNNVcBCA1oU
	 0rOokyvnWhslg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66688405D1;
	Mon, 16 Nov 2026 10:40:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8936C28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 86C48401E6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:40:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7BsY7HfgLu5r for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 10:40:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 798794009D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=eu3TNhTX
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 798794009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 10:40:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1FD6960D4C;
 Mon, 16 Nov 2026 10:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C7D1F000C4;
 Mon, 16 Nov 2026 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825621;
 bh=pG0p61DmGim8TIRru+2cHTsNX2BkrFrrGNkEnuOzjzU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=eu3TNhTXXPckjhG4ayOnelZ3KyGH7aJ4B5fmiVKqgHDoMpbS9mUapxsXQThYMjrrZ
 ikZFYJHNyUB/xkyPpwTASi1OoGBxpps62HiER1/ELjod0m9+07hy9DjcrTtIRxlxqN
 9QhYnDgfM2Qcphdq9V0OqEhaBGk2VYqciR4z98GU72gw9uIL7stL+nfQ0fMALjmXyR
 T87WlT1QptP1VOEQldSyk7wSbQAuDFk2i1ktY6buL4htfPBy5Tp63Rsc1QoFc552Cd
 ceAjXuWn8Q+VBE7FDOquSE9AlNTKvHUKCv6Zcm9Yv18nv56hOpG+/xnpdeWq08qcxu
 opBG7+k++YuNQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 u-boot@lists.u-boot-project.org, Sebastian Siewior
 <bigeasy@linutronix.de>, Rob Herring <robh@kernel.org>, Carlo Caione
 <ccaione@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Francesco
 Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, Aristo Chen
 <aristo.chen@canonical.com>, Petr Hodina <petr.hodina@protonmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Lukasz Majewski <lukma@nabladev.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>, Sam Day
 <me@samcday.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov
 <alchark@flipper.net>
Subject: Re: [PATCH v2 0/7] Support fastboot boot in SPL
In-Reply-To: <179458689495.70612.1391691837782870153.b4-ty@b4>
References: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
 <179458689495.70612.1391691837782870153.b4-ty@b4>
Date: Mon, 16 Nov 2026 11:40:19 +0100
Message-ID: <xhkdbld6tqcto.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Carlo,

On Fri, Nov 13, 2026 at 17:21, Mattijs Korpershoek <mkorpershoek@kernel.org=
> wrote:

> Hi,
>
> On Wed, 04 Nov 2026 10:40:20 +0100, Carlo Caione wrote:
>> Support fastboot boot in SPL
>>=20
>> Test farms need to run successive U-Boot builds without rewriting boot
>> storage. Add optional fastboot boot support to SPL so an already-running
>> SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot proper=
 can
>> then load the operating system using its usual boot methods.
>>=20
>> [...]
>
> Thanks, Applied to https://git.u-boot-project.org/u-boot/custodians/u-boo=
t-dfu (u-boot-dfu-next)
>
> [1/7] spl: fit: reject failures loading an explicitly requested FDT
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/1a3297db459c3baebdd7d51a7b6e740d3e29816e
> [2/7] fastboot: invalidate stale and incomplete downloads
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/6abd0cfcf58db69fad1130a8b4b1c3584b2f7de4
> [3/7] usb: gadget: fastboot: do not boot after a failed acknowledgment
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/72e4069217d76b4d358f561dd2c8160acf0fe485
> [4/7] spl: ram: allow loading FIT images from a supplied buffer
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/154c4246d60a2012d5fb23920fd1e77e7159ea55
> [5/7] spl: support booting FIT images downloaded with fastboot
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/fddc8df36f5219e3742e3b8eb3a9b0f21c30b315
> [6/7] spl: fastboot: support legacy U-Boot images
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/02172ea8e838e9a3a00b30bf7f868d5b273af173
> [7/7] spl: fastboot: support raw U-Boot images
>       https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/commi=
t/4dce3b1e0e17625ed73f37784433c54da4cd719c

This series seems to introduce some build errors in the CI:

Building current source for 1 boards (1 thread, 112 jobs per thread)
   sandbox:  +   sandbox_spl
+common/spl/spl_ram.c:109:12: error: =E2=80=98spl_ram_load_image=E2=80=99 d=
efined but not used [-Werror=3Dunused-function]
+  109 | static int spl_ram_load_image(struct spl_image_info *spl_image,
+      |            ^~~~~~~~~~~~~~~~~~
+cc1: all warnings being treated as errors
+make[3]: *** [scripts/Makefile.build:272: spl/common/spl/spl_ram.o] Error 1
+make[2]: *** [scripts/Makefile.xpl:553: spl/common/spl] Error 2
+make[1]: *** [Makefile:2452: spl/u-boot-spl] Error 2
+make: *** [Makefile:179: __sub-make] Error 2
    0    0    1 /1              sandbox_spl
Completed: 1 total built, 1 newly), duration 0:00:34, rate 0.03

Link:
https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu/-/jobs/146829

Can you please fix this and send a v3 ?

Thanks
Mattijs
