Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15EEC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 15:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C2B340AC8;
	Thu, 10 Sep 2026 15:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JmpfnTOo1Lqv; Thu, 10 Sep 2026 15:09:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AE56E40AE3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789052941;
	b=OfoCvmS+wUU9EW7pVzQXz+YlFkoVNiBrVlV+3O+udtbbMsyZUrODxrJnvj1dr9FiMuQn
	 h4HNbdoJvMuH84h4/bDVrfTpviN5nbR0g/Sc2Fy+BI5W8yo2mHL7UvykH+lC8nXabvE5u
	 7tnOqjIVIAllu3U2O5UIYEJctICkOxLl2YO3+Z6IbIsLV9KGFt0+rGNtZuaYmzWUD+A2h
	 bpSftcSI2YEj3rpNlKqlvJzLs498xzZJ4YadNrqTdUx04wh64CL/K2JgYT1/81w+x5wat
	 qRVQuyJ3xzSnOZNNHlxMYOfnYwWIPiz3wGgFN54D2RF4aDUo31d1SdHFja/JtRyM9OQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789052941;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gyj0hDGjYjBV03m1WjnlrUl1M6GSKPtkO+o/3pWTvGw=;
	b=qHOkEgGgIanOgnGQazVWD2wzM7FbHqynBmOrI99fejVYZOBWx1D/ArYK8MErFH3lb/8Q
	 W9EGbpjtmQYeWTrndGicMkkUYU5ryus3WlqtIM38h8WCCCF3jvp1/UpJnxHYuiXpo07Wp
	 PccIRk4hdmV2xT5Z9DisFkzzrGEC9XO/4ojyXn5ZPJ4ASca7xuYHIVUXq4KTrrkUwBhhZ
	 u0GgsYsQOGWL9YjLrPT+GZqiWTR7t4u6grI+zFj+OoL1KhUi6dckMglNMEo/439/jxTMw
	 VKBCmUqPAWP2UNTam0pSsWzXwm15f1bGscZ7Cpct0qmxken0MzcTIk6MmXUXPmjgolg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789052941;
	bh=gyj0hDGjYjBV03m1WjnlrUl1M6GSKPtkO+o/3pWTvGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvMBy+vsrpqKzuDe84zt4a1raETwaThQZaC/bye4Uo+tO+bT67uEzJCDO8cOTiPW/
	 lGAy9+QrO6LhMSqd954IPs6Q3xdNyCHQVeB1o7AysfO0Ix0VFhKgEkFKrFyLB/1Tk6
	 N6P2ruEgA1Nccox53pqfbIMeJDcoxgYr26GDsf41H8iATul91VpTCxPDkFu5rLmc7T
	 03HxY9xK29EtA3XOjy/tecI61sMuGyflQdaZVLjYMnN7iOk/YPuzvazUp5WU4z9Y3h
	 5q8CVjxGoZvjfadIgBhSKrb6kKRJQxudLy7MZejFtANTW37yM76qDHMn0W5dUF2ckK
	 C4k/Rj2nb6kSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE56E40AE3;
	Thu, 10 Sep 2026 15:09:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C43EE11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31FBD60B21
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3LLIys2YlIcX for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 15:08:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3ADC160B60
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789052939;
 b=kE3Q/cFJn49y/NWl+sHKzfm41HeNDdbz08HDp3I44ekViMHxMPvoU4PcevFRDEfNBXM/
 7SmmufsgZ3gmLZhKrVQgbK1ebjUoFeaQDpj2jvfxHRR6nkRuSRFzGXdlaVXMapUaUTSO6
 MuRO9LW0fhPrg7C41RDubwzpVmKgXI+6wwi8AEkYPjonwSZ8GoF12GS0lJm7+JPG88ZAT
 ZYpncVV9DykfoOH0u9o8w0FNo7ztqEKQejL6WO0GL1vVmP8gAvdOVw2r9WuwRPHx1FMhv
 gkMl6AvkO4eHPt26TZcMTCbmzDROfZyCPDWRLizi906D5QT7n+crwAKz+CoTs+rJn8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789052939;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gyj0hDGjYjBV03m1WjnlrUl1M6GSKPtkO+o/3pWTvGw=;
 b=FsfRbxLyapOCJXwW2oHSBWrIKEQ+MjqB74xZ2kJzzVQgEfifHeulOWdoL7tJchWAtQxc
 80xjmxJXGQ8OATTxmclt0u+kjKiMSlph9OoDKcBSZQkRZ46UKISvfhi176wUnVm4FJ2fr
 q6fowA6GJqBzIcU9t02VYlNDJbCDmzuc4otAXV5Yro+J9KFffP3N59fYXhlEm+58Twhjk
 ho24hR1T3k3rSr5axZw3wk1U6V8cKPGZq3zLX9WJVmlmdtnLdhcpawnJC9WXuhYu8upNg
 MY+b5t3YHq3pwEyR/CfP/QU5mkftahmevZ0UDYjrJRP+2mUdz9cLKb0ltz3a6FcNFRA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PW4ct5jd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PW4ct5jd
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3ADC160B60
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 15:08:58 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so11044296a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 08:08:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789052936; cv=none;
 d=google.com; s=arc-20260327;
 b=bwQ9aJo9Sfpj9TJaBwxwFyNW8e/IsJykEth3FkRZNTS1H0IssKNOBBIh5+SH+F+Z6r
 LUoHIQTHI/B/Yzwfsg+hQuSZS7e5b1V1dMX9RfYTdE5i01vEy/z/K/g0x45QCd3uG9x5
 PPrB0D2ALinzPNcKtuSPs1A1I9W9DrgP8Nxd4PLxnQyv6PqjQYLadlIrMvueQUpDLJBD
 JTtHK+HchXNqA7iPfgrVCBE4AXrP4Ps6iUkJLupipM5AZWY6VlBhCsigJEDFzHF1Sb0j
 xJg8V/ugvWYcTYQRNh5a658KkeAZWzuuSjOjUfp6jap9HtwfW7tCQ0bVYXLc1j7T70NM
 22zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gyj0hDGjYjBV03m1WjnlrUl1M6GSKPtkO+o/3pWTvGw=;
 fh=EdW5e2fqYzUsyMhXQG/py/gzjgQSkp+ub1IwfMCuqEk=;
 b=DQA2bkALLiuyat+ns1EN1/v2yzotWKu37xCKml2wEpgPBVz+5FsD8qCv97tHN2TjSO
 NOOOR2fbg/UNaBTGpXvYMgvR+0Z3G+GfatnU12jmKcA+rrVPnVbkT9bfwg6fIASuOYIY
 dj2lsYb1jxv+H0z87G3JOxpDW34XzZuwWLJTI9sEM1m484Yaetb7NJWIvB2qB/K/zc/O
 yAtLOIlE7kYRr1v0IcOP6G5II+KR6DKQrX213LC9x8mqUamDLvewL+pmkXSPJ32MBta1
 g09DTKiQBDxqYjpn8QcphWFME/nMX1QNWeCo5mgtEOWywHV9fZOgRZeMJbK/9Z7Q7V6R
 nQYA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789052936; x=1789657736;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gyj0hDGjYjBV03m1WjnlrUl1M6GSKPtkO+o/3pWTvGw=;
 b=PW4ct5jdlX/cc7drATwg7ihwlvwku0DRV2cgufEhnWQYGw5AcwghRRlyhf7zClJxEa
 UUGtyP2HVaPiI/DTtvpYLExBIJjhX+MtwcBrzviqz8U6nwY4Egse3PlPKSSfpAWUj8U/
 HHcIL0YOTRWgeZRb7n1EdQudG+UNG83fVDF8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052936; x=1789657736;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gyj0hDGjYjBV03m1WjnlrUl1M6GSKPtkO+o/3pWTvGw=;
 b=VZ+q1Gd8Dqldot4umZ4TKpEOSJjdLnMKSXEv0Z+r4rMAmeTwqu7Tntm4GFvbK02mJA
 MvQBgX0qjvnJzHE4S/SGZovnp2y88nY9LbBJTaEfz3NztTQFWUHi7UaKYa+Vk6qZY3lp
 lXxmbD3+m2lMFYcl9a2PnnZJM6UepXJj31ZaJns98VFvxwUkheOl8ixMdra9n1Sn+5Hr
 O/X2UIYvZJmQZlayO9n7x4ZhC+MJwSGi39IE3bSI1n0NtHT989us0i61pa+W0yqunm3j
 uQK2j6/EqKKi+co5nsZt59ijHqj6CfGYdfzjwD9pKyVnFL6/ixIQSias/ECrnNLfhXZJ
 UV8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUa37fm5Gh0LDxOIiRyD73s21QCAocw3NWwszQfKvRdk41xNWdRXcJnNxZ5ITKJvvNcqcx2NE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nuUrwcdPq586FLSsGoBqIahKWpu1Upp6ivmFvXRIKZY6rfUxDd
 22LrD3pLpLgU1+/M/TrO+WDzaaIXIJP/pVDoPctvwm5Um8KjPS7JyVhFd5gh63KpCAmPbMqeCPk
 rdB0yDfnMBoodFwsBIDB0bHVI4xyr1E67h9tSRDU9
X-Gm-Gg: AYBFou0v/LOQMenes98Y6rqsYjQut6aiPlLdLGbr++ovtrllo34Sf5P+mLFOKoXhzrQ
 oWi4HN7X6JZJpbIb9J8R3A5UcqA9b5R4Q0d4Y+ie4Z09Y2G+SxjaSW3YCaodU/FCwQRnnSHKKn7
 oJu8nwDdgP2NzOSVWppiiw6SVFB938dFcUXYLguSphTz8XjH0ja00Y8bZtYvfZPmbHOPfwa1rrq
 w0zk8h7/FgabItw3Pmp4k/M5VvOtiIsDVzKAf+SfK+UGX0rHMOJTGytchwNqddVbD8/eTuJ2DWM
 xGE6nu5O//A1fct3SCUjxxGoG5EWtlLcZrgYoUuxD0uXkfbZjr/TJe70igsNmS0nlg==
X-Received: by 2002:a05:6402:194d:b0:6a9:a1a1:60ee with SMTP id
 4fb4d7f45d1cf-6a9a1a16367mr3094614a12.23.1789052936581; Thu, 10 Sep 2026
 08:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTi0TpqNDeh5FuB9966FRRLqChr3ffhvS7cCzKfaSufLPA@mail.gmail.com>
 <20260910145826.1275945-1-mehmet.fide@gmail.com>
In-Reply-To: <20260910145826.1275945-1-mehmet.fide@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Sep 2026 09:08:45 -0600
X-Gm-Features: AcwNN1VO2o0kxi2o8ZDxg6xaUy4etadhEXsBzUmEZ3s62mnoewV77ZyAcYWCpB4
Message-ID: <CAFLszTiyxfbQE_3c0DE+MC4j5GK4vcrsZfqSPiypNf2SaYUhFA@mail.gmail.com>
Subject: Re: [PATCH 0/4] dm: gpio: read GPIOs in of_to_plat(),
 request them in probe()
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, 
 Michal Simek <michal.simek@amd.com>, Aristo Chen <aristo.chen@canonical.com>, 
 u-boot@lists.u-boot-project.org, Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mehmet,

On Thu, 10 Sept 2026 at 08:58, Mehmet Fide <mehmet.fide@gmail.com> wrote:
>
> Hi Simon,
>
> On 2026-09-10 Simon Glass wrote:
> > I wonder how many other drivers probe in of_to_plat() ? It would be
> > interested to get the scale of the problem, if you can.
>
> I grepped next for gpio_request_by_name(), gpio_request_list_by_name()
> and dm_gpio_request() called from an of_to_plat() method: 50 driver
> files do it. By subsystem: video 22 (panels and backlights), net 6,
> mmc 5, spi 4, usb 3 (ehci-vf among them, which is where I started),
> pci 2, i2c 2, power 2 (the regulators in this series), w1, tpm, sound
> and misc one each.

OK, not that much then.

>
> Most of them claim reset or enable lines that they then drive from
> probe(), so they would convert the same way the regulators do here:
> parse in of_to_plat(), request in probe(). I can only test two of
> them: fec_mxc and fsl_esdhc_imx run on the Colibri VF50 I have, and I
> will convert those in a follow-up series once the helper is settled.
> I would rather not touch the other drivers,
> the panels in particular, without hardware to check that moving the
> claim out of of_to_plat() does not change what they power up and
> when. I can post the list so their owners can pick them up.

Yes let's leave that to others one this series lands.

>
> I will answer the per-patch comments in their threads and send v2 once
> those are settled.

OK thanks - I didn't see anything in your replies that needs my input,
but LMK if I missed something.

Regards,
Simon
