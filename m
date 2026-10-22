Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534A606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vojMKLgr;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UyX+f+MO
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CCE5403AA;
	Thu, 22 Oct 2026 20:49:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6lAmM0pxk6E9; Thu, 22 Oct 2026 20:49:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B2764047C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792702146;
	b=j2ziv7pkb3k98mVPK/qsJw7MXOi2QiuGN7wrMGgRlXyyDKeJvH704ManJRHpOA2UI4V1
	 33yznAA8F6NYVtcs0enqj1czM39rxg0O0gLKnQ3xlu5jBdhkscVoHxlaUqRCk5m+ATfEa
	 Zjm5uT5K+tFcurIAKpGnG4yovsvzZ4k6xzuw3l3tx/cjndq4Puv7+iTGCu8bXoncofGaW
	 XGBDZ+i6FUzHdp856uKb8TgfPQJdiP1DBvAfbSgO02/dRZ1iEWMi3ZRgLxYbVLFS98bSE
	 fACK1++/ZjggKlcy2EG8jBHSSX6DPPuTQDbGkcWyR0szjTY9WAPl56igVOgfCQ3Ku9A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792702146;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+3UTCZjRfn0c0/VJECDYE39rmacw8Xh5KXhwprCQDkI=;
	b=DBVk4Xir1hSBmm55S+fQ2dTFbR2jNtHczRNFIIa226yx8hbmihsaoQDczsTbw8LBpsb4
	 6OiERT05il3iG8P0I4wyJElnsB7N4zK35lu/p7Ob55pCxi5qU6MGrm3GSDpcQ/4IWDp21
	 dOEMoq4qM8WRACDOkx02KS3zvT+etMg/s3yJtKNo+39W0v70FppunanWAxhY7etC0jliw
	 GmoPx7eK0RQCKhqzZWkyaveXHPJ5uk4F1IzVEdNonQQNkzcIBEE/Zs5ZhhAnf/ED+6p62
	 IqA2Rz4fYISs2YJGiI8Uhf55UGfPt2UIHppxOg7tZ7Xeztkj0L1VOH+3RRxVpUlPxmQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UyX+f+MO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792702146;
	bh=+3UTCZjRfn0c0/VJECDYE39rmacw8Xh5KXhwprCQDkI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vojMKLgre9LMmyPpvkqnoHgm0E2nMJm+aTKlcuYcEGMJf5WGKl7tFaXVUxY2f+epT
	 r1iWyQSLjhLd/rfEXZH4fQX8500smrVuWuNmvTuSjKx0sB78OcquoSHnVUDtIk7ACL
	 KlHElFnxWIthSBbviyvH4TD1J8VcHgYx1Y3pyiGv8jQvwO5npSVv9P1KhzNNCqPF/2
	 tMCCAI98bPrQSJ+2XcLfMqRd2T3aJyaWtaBrYiw8zS7Oq4aglehfo8o2Ovw/F32Iwd
	 9J2Rn7Hz8kHdnbs34B6OomccD35U9NFKB2+V8/0YF2O9mBga70KOyJU/QAEAEGS283
	 ukcikd1huvs4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B2764047C;
	Thu, 22 Oct 2026 20:49:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F11B3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3542D4047C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:49:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id US1k4nEXLUIO for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 20:49:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 34BB8403AA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792702144;
 b=HLWgLXLh5n2L5wJQOe6ycnWFHaCUHC5eaLFdaCIPfkG4dIvD8I8T55A8mjJXtnfTcuQg
 MwJZMJUhouD/zlO++ir8uNZa3EiUOEpIKHyuEz50LaiQzoYvteAJwqQSL2EGHn1p/NtUy
 Z1lj0jad/tK606jCTWiqe1r7vZ8Wq4ravr/kb6vQTO/V9hmNw4rtecuI9pDEiB8nqBA58
 TUklWCDL4zodGahj5a56hX6Tdm6dnFMQnr0W+Seka56+P0T3BgWoCMUytlU7ng/GkWN/Z
 9+22KlFNIjic95fDBfxieOhnYXT8aOQ4nAC8setmMv1pT07p0oDbhZxHYYIOuU3Ilgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792702144;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=+3UTCZjRfn0c0/VJECDYE39rmacw8Xh5KXhwprCQDkI=;
 b=DNk1pkpbQAkryitXHcxKTBidrYuerXAziAUcRF0OHzcX4/QfmC/qMLymGqYZkBkTffb4
 lIzW9Lk5is3BRFc7BUF0W8FMgfBHaXpKRQuEszYc0SYOWUmYqxPTpllZuBiQkDp7CJHh7
 atybwRGpjXrkFNysQ1eUFZtxG/lr1lqwJ/5J54RwJIHno2E6gghiiBxVZou0QhFlapVez
 WinRhA1WJlpZEWDVii7o/Ms4O8//Ws9QU9NJtOjkaV+QbDd0ACe2xNYQM/rchyAC4B9YN
 c8hO3CywdsyaBDrwJiqZPIc2r9FBtfzxTpst5KSxFJBLTpOTuOu+XeErOl/TlMhSbNA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=UyX+f+MO; 
 arc=none smtp.remote-ip="2001:4860:4864:20::32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UyX+f+MO
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 34BB8403AA
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 20:49:02 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-499f20c7054so156015fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792702141; x=1793306941;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3UTCZjRfn0c0/VJECDYE39rmacw8Xh5KXhwprCQDkI=;
 b=UyX+f+MOs3nANGpJS9KN339wnGvGfXjhYkt669ZwgBZB4KfDGqbLamqSEpKbNDu3Z0
 AkF8F44w5N3U2TazTPvWHOdpTz8UKqxDF36r7Oq5YRYUeC9snrj8kpJJAd61C+23oENZ
 FMpxUH4HCPMLd2ahPtTScWxITFBjvvnU6lntYGwNRkX2lCnU7XVSs+br8s77ImoJjyit
 AARVMWz33kno948ETuO1Nt2AKXgXdbNyKKf67NsP3tcS77QcTq+zbWk464z6vMaTRZlJ
 5ZI0B3ejMwkssYybbloHBtEOsJc2N0PL+CvyNl/KqAictFthPbrH1v1NjIZkzZwuoZsd
 neww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792702141; x=1793306941;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+3UTCZjRfn0c0/VJECDYE39rmacw8Xh5KXhwprCQDkI=;
 b=l7uU5BMzXcjkqDrmPpkRarMP82Dwzj0g/cZULT/vT8hwqjX7Gouf8JYWLKeHW8mWYi
 yDkYMHgvW/u6BhGsHj3/GhzBJVtfhkwkk+rHWjmiuOxgpLSrd7mc1vbbpWf3uu/jIXz4
 IlZnmDPBqBepWe0QJgG/RWv+10Dl32FUZ9kzl59jyjSWkC9ZeuWT52juSvM3vJhEfjf+
 nVzs0yhuQaRcxlZMbDj1ZvmugGOfUAZcYn54K1h7psAzvyguWfOKfxghLObnKcJom/sv
 qGd8tpBLccz2BFYX6y7GAJyrnUd4xcjk6Aqq3vuj58rk4+daDMThsO5lTeLqXCXmt2/e
 iKSw==
X-Gm-Message-State: AFq9FYJaMQjpbkNNs57HfPi2jaPERABRzKFEG9Og/Q63T61g8uGaYZ7p
 XbcyJQQlAfjp68t4aaBSwQS9IaP+LXHWWQ0Xa8NCt7qWEUnxoM/gUeBxfHpVsZNRWz4=
X-Gm-Gg: AYBFou2AmVTaF0eKobO7wfRy6T+pJm/kubsZMztzq0tNSkHfBFa2K0MPxAqJYf6sUKA
 alnGXwJ8zmlZZKC1eGWhER90ShdzsVIK6cLpLKalFDKLjAS3flIYKYp35jloZiPmdrTErFRDNfk
 NJ3nD0B44ETXm8UmsvI/hW6PebUdIcUQTe1q/Z1x6eYS2dVk55UiQy8+PZ9B7a3gtDGWdb6AkJ5
 Kh0DK6zvxcwuT7k5CKH9+ZFZAo0G8pZniMKYBx4I0pI/B1s05dM+rdIobq7bjB1I8XE5+ROhRNX
 fRxk0dxBh/xebg5qFWSnn4em09V+munFnqZFrymgia5NpvZWwnGp+2/rZpChTyhG+uWouvy3qQJ
 McYD3r23qfxdnisAs2p5hNg2Q5KZ3qbWCPTTu9CAlI5sy/Frb4H0Z0dvkMnumJ/KDJvL1z2Zmrp
 3zPebRQMu8BlWovwHY9S2kAhX2ZUXUAlbhLcSDvfs8CQCUvMcO0M8o2IWmEVsbC5qOHJcELIFM3
 rmvZR76PDMvohp8M+FSR9P1EZgyFOU7oWNCZFRbXBz7Jl0pE+NHN2tsqybw
X-Received: by 2002:a05:6871:e41b:b0:462:ed80:2fdf with SMTP id
 586e51a60fabf-4a82215b887mr12625fac.17.1792702141507; 
 Thu, 22 Oct 2026 13:49:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d0bd:a587:44ef:f6bb])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a820a6bf5esm129772fac.11.2026.10.22.13.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:48:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@nabladev.com>, David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
References: <20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com>
Subject: Re: [PATCH v2 0/4] clk: mediatek: propagate rate requests
Message-Id: <179270209695.3711947.8515917435953101820.b4-ty@b4>
Date: Thu, 22 Oct 2026 15:48:16 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1152; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=maOZS0gNr+1HE5NVcDiPAubCR7es4Gx3bEPEINDmKTs=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq2nawTykOAI7kW8NfCnVze+0biVw3WQT48IU4q
 YZ0+Cyey4+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCatp2sBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Arv8H/3suqEQirsp+LQSQA+IX5QZU3Xs2mMZ6hH4WX3P
 oWxB7YJCK878Bv7e67A4cd3a+RPnQtWdqcQ2LcKnppbuEg2i4NoqE9hcJcTVLWRGt1srsTfcGC+
 hNkXCue42CEcm06tnMjNGGvIbm8f49vPlO9lN/a0VU/tvDcCH1OPBJBTDlNJLPcw+QhEWuMu3/M
 WMBpjTG3wmAqPWpPnO82Q3Z1GKyWRtf7yCj53CPKfSdCYiY6LUDU5KY66BcMXUbTTCrfsH0QKuB
 kl+EfhzGkUDBw4UTkInom5TkMkOsvaH14gwaV5f0o3bdsxWxWZ8uToYO6KP5vfQATCPDNr4bIbe
 drEs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 05 Oct 2026 17:42:46 -0500, David Lechner wrote:
> clk: mediatek: propagate rate requests
> 
> We will need to be able to set the pixel clock rate for the eDP panel
> on Genio 720, so as a prerequisite we need to implement a bit more of
> the set_rate functionality for the clock tree. The way the eDP driver
> will work is that it sets the PLL rate first, then sets the rate of a
> gate clock to get it to select the correct parent, which is the PLL that
> was just set to the exact rate that we need.
> 
> [...]

Had to fix some minor merge conflicts when applying.

Applied to mediatek-for-main, thanks!

[1/4] clk: mediatek: don't truncate the requested PLL rate
      commit: 6bb527eda7b8ebc31e72fb215b82f9051809b6d5
[2/4] clk: mediatek: return the new rate from PLL set_rate
      commit: ac28a81ea7b5eaf9517c58c55d903112d80a0e6e
[3/4] clk: mediatek: pass the input rate to mtk_pll_calc_values()
      commit: ecf35ac0723c425eb54e504dbfbdc2547a28805c
[4/4] clk: mediatek: select mux inputs by rate
      commit: 41bb88bb2488c0ed23f830b3e9393807c83090fc

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

