Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A971ECA5FE2
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 511E880D39;
	Mon,  5 Oct 2026 05:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IpLz2zmhQ2KD; Mon,  5 Oct 2026 05:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1476980D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177165;
	b=Ob9ZcrA1Wn5s4m4GMCAiKpoFMzlZ3E+YIXfqAa0VPdI2FXkxryK3X2WrpZV1wySsEKKb
	 YMpzySuT/3fU01xekX1inFbct+qkHsHG4r0rWovtP4rcSsAj1xTIu7kc5thLcmOJK04y5
	 i3nzw3f9YcJOn88h2stEQ96HIp52EINpRYdWTjVmlTiOkSRqrMzKuVuPpy4EDvqCfLX3a
	 gGzouTEI081I3uKD1um9E4ZQcrFfAnqJ8L7Qvj3HXWphAoldtsXMrMyhH+DGRqwyi9yM2
	 LjsycaKQTXmNMgmzr3WQ3YyYgKYxMsGp94fkXvD5LGnXxKqNmSCZ/Znv7Gik5ooWnLA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177165;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9LoVFCWwjjhFEO3AmolAbOeEg2m/BIXRc+JKkZZKiVo=;
	b=h1wfYjA1+zZ4eloT1B3fb5QFdj5EPikvPWjAn6S8ZjjD4WAsRH4pjfSXGT0WMd/6ld0s
	 i5Uf4qgQsZ9tRbsHltFxQvUaV14eYSqHjaKRRUDLYsElBSxJWFV4EFgsWaMLhl/lfebbJ
	 lIqO/JMoMkG7TWUK3g+Xm/yGNbCICXFeuXOlijxa+tpXBgD6yrrz/eLnVaVuxCHS33cWA
	 IRzZqIdg7CbNYZiEWwx4maFtGXNvMtHBnZW+QQe+iHyGYBhwifz3m7ZNJYHf1DgWKnjJ2
	 enqu9h9ujKvDk8LMDDzxXS1/7ZPHWoZlFLjTzduJgIhddElaO2MS+2V+/toNRhBBtRQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=none header.from=iav.lv;
	dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256 header.s=zoho header.b=YjMlvA7w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177165;
	bh=9LoVFCWwjjhFEO3AmolAbOeEg2m/BIXRc+JKkZZKiVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nqzproeaZlcWfRXRf7G7kRaqEBBtvcLeyzR+gyzK0D6dpPPcYmfx1l+7aBA7F//VI
	 DMFWGNSf0eJ2biJFwTbpghEKe8rsXtPxY1k3AtESw/1JIyWlGRkTRRGxVpSA6J3kBS
	 GJm07DWXPL4Bp+apl8hHnhJHj4jQVz6atQbogIkG0EzjNojn2+NSiAJP6OQbFynL8w
	 LwYlu7eweddJRYZIINsPM0Ooziqzf8bwl2jLud8Grai82JRCMhxtRqee4x6moU/k1l
	 0ICP5j+DwXIvHQiODrmO7bfCl8onB+L1Ts97KXBoStQg1gTX1zzp7jnJzqJg/OXpiD
	 wz/tAlg2lejmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1476980D6F;
	Mon,  5 Oct 2026 05:12:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C60872E0
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 17:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7E5480E08
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 17:56:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4vVZAlrYlyx for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 17:55:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0EC4080D9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.169.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791136559;
 b=VFlG/xyhlRIOuc3b3vOcSXtWXiXlRMuDXKIfs3WpvesmLHbUC55SHDFpOZTMgrlPFe13
 VfS5qNHo/QC4bj77S94bZmD1FrQ0IbIoSfsuE/1JxKTAkYdN228/7dGE8+FxUGj8/8kvw
 naqUanMQtYypM5OJhsdRYQifBlayd+H1hPkk9N3XGLD6Tyvzge8OWJrtZ6mKCR5h6LVJV
 AUau/TLLqZNBMYed9mFCxxKDeDDkLbnje6yOfILaxQUMcYa2n5tAxUfMX2np4FmNC2A8x
 MhdT5gNwB49HMcOxnTbrf412WZibou7UEGUQ+h4uGN4RjziQN8HwDaJXqpOhHS72jWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791136559;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
 References:Date:Message-ID:Content-Type:Content-Transfer-Encoding:
 MIME-Version;
 bh=9LoVFCWwjjhFEO3AmolAbOeEg2m/BIXRc+JKkZZKiVo=;
 b=UfGVyKcQFlzAuMtmUr5Odv7DlB8AXnFx7+O9O6W5vcw+Xg3DPNiqA9eMp6pqvf/iOaiA
 2Rj8IvXlHrIy8kbcDQX46+pne1x3DocQb0dfRWRtinq2pXlgjIleqRji+3kMqbiKj3rKw
 bAy9wzevxh6K225GegDWaIDOo11rsT71JkyGa3Cbt6dZXHmNAs1TZNCGnFk2RqMSXY9QC
 p8MZBGdX2cyjQWdyZFEhidPXlyka8a/tONPpRSJ6/2+JUrfqtsmwKM8fO6tGe90g6ZGLA
 XTRA2oVpTmIPhFpsR8MOh8k5hnAkdNIljW1l5yXt+Uol0rG15KJsMH+x23UtlFH7xgQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=iav.lv; 
 dkim=pass header.d=iav.lv header.i=iav@iav.lv header.a=rsa-sha256
 header.s=zoho header.b=YjMlvA7w; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.169.16;
 helo=sender-op-o16.zoho.eu; envelope-from=iav@iav.lv; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv
 header.a=rsa-sha256 header.s=zoho header.b=YjMlvA7w
Received: from sender-op-o16.zoho.eu (sender-op-o16.zoho.eu [136.143.169.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EC4080D9D
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 17:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791136555; cv=none; d=zohomail.eu; s=zohoarc; 
 b=Q1glfK0Pkrn8zYItLt0EX3zj4T3RhixJCItr3pjOuyYE1LoQ1UKBJ7OQoU1sZVmGAsUmplOsBbI+Bm6V61O1K4N2xIUd7/D/vWwlqdJ1RN+IOeRG1vk/Tqc2HdqMvf/RBQuhr+LNkAEOiCCsppapUunaFt5e9Gf+hHopZo5nXBU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1791136555;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=9LoVFCWwjjhFEO3AmolAbOeEg2m/BIXRc+JKkZZKiVo=; 
 b=FRxE4/62rk6ePbmGmUvV0Dr19pqpE8WC8TvET3hGZaF3E/cc3hVaV4YXwijgO0x+PGxby1uAL1aEH6zRkPFKQOAgHIGwueP9+NyFrbgHnGML0kfR7n1cn5+zIxskhotrqNp3TgRhMM2hlThwTAEgYh3SW8Qzg4I5S1qjC7VNQkY=
ARC-Authentication-Results: i=1; mx.zohomail.eu; dkim=pass  header.i=iav.lv;
 spf=pass  smtp.mailfrom=iav@iav.lv;
 dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791136555; 
 s=zoho; d=iav.lv; i=iav@iav.lv;
 h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Date:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=9LoVFCWwjjhFEO3AmolAbOeEg2m/BIXRc+JKkZZKiVo=;
 b=YjMlvA7wSjea2MXv9WquxF/M2VwOgjzoW9g8aBSBxuvnVTunN6BrfcjUhjMpki8H
 kyZ27TwjJBcapNM99Kxfr9ESqcTqzgBjeN7Rdgw2swI8OYEoAo05g+KvPI/8E5BBLiG
 SC9PxSsBtd+EdPb9jMlbh7GbGexqCuh6HGzDa5AE=
Received: by smtp.zoho.eu with SMTPS id 1791136551847497.55920227338163;
 Sun, 4 Oct 2026 19:55:51 +0200 (CEST)
From: Igor Velkov <iav@iav.lv>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] spi: Probe a device tree device at the requested speed
In-Reply-To: <CAFLszTj_fXh+4c2Ldq4cw8n973=R-1z38SrE1cp6-Z0hy4+USg@mail.gmail.com>
References: <20260930-spi-probe-speed-v1-1-ff9aebfebdf9@iav.lv>
 <CAFLszTj_fXh+4c2Ldq4cw8n973=R-1z38SrE1cp6-Z0hy4+USg@mail.gmail.com>
Date: Sun, 04 Oct 2026 20:33:40 +0300
Message-ID: <179113522079.1894383.11891966557600672757@iav.lv>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:17 +0000
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

Hi Simon,

On Sat, 3 Oct 2026 at 06:41, Simon Glass <sjg@chromium.org> wrote:
> Please can you override just max_hz here?

Yes, v2 will override only max_hz and keep the mode from the DT.

> Their flashes are now probed at that speed and stay there, since
> slave->max_hz keeps it, rather than running at spi-max-frequency as
> they do today.

Checking this led me through the history:

- 96907c0fe50a and b0cc1b846fcb ("dm: spi: Read default speed and mode
  values from DT", 2016 and 2019): a device with a DT node gets the DT
  values; the second says "even if speed and mode are requested" and
  names SPL boot and the splash screen. The SF_DEFAULT_SPEED help says
  the same.
- e2e95e5e2542 ("spi: Update speed/mode on change", 2021): after the
  probe, _spi_get_bus_and_cs() calls spi_set_speed_mode() with the
  requested speed but does not update bus_data->speed.
- 3feea0ba196a ("spi: spi_flash_probe_bus_cs() rely on DT for spi speed
  and mode", 2022): callers that want the DT values use
  spi_flash_probe_bus_cs(); sf probe uses spi_flash_probe() only when a
  speed or mode is given.

On sandbox at a6ab6a66146, spi_flash_probe(0, 0, 1000000, 0) on
spi.bin@0 (40 MHz in the DT) leaves the controller at 1 MHz after the
probe, after spi_claim_bus() and after spi_flash_read(), while
slave->max_hz and bus_data->speed stay at 40 MHz: the claim compares
against the stale cache and does not reprogram the bus. rk_spi behaves
the same, as its set_speed() takes effect on the next transfer. So
these callers already run at the requested speed after the probe; only
the ID read happens at spi-max-frequency. It also makes a sentence in
my v1 commit message wrong ("the next claim of the bus goes back to
that frequency").

> Just to check: should a requested speed above spi-max-frequency be
> honoured here, rather than capped at it?

I don't think this choice is mine to make; it is about what the SPI
uclass should promise. The options I see:

A. Keep the v1 scope and override only max_hz for the probe, so the
   probe runs at the speed the callers already get after it, uncapped
   as today.
B. Honour the speed only for an explicit request from the shell
   (sf probe with a speed), where whoever is debugging answers for the
   value, and keep the DT speed for everyone else. That also needs the
   path from e2e95e5e2542 to stop overriding the DT speed for them,
   which is a separate fix.

Which would you prefer? I will also add the checks you suggested to
the test, on spi.bin@1, whose DT node sets spi-cpol and spi-cpha, so
lost mode bits show up.

Regards,
Igor
