Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4767606A32D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uepRSMud;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zmLs4dsa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D4BF80DC5;
	Wed, 28 Oct 2026 14:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p2a5ekjoyw51; Wed, 28 Oct 2026 14:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CF4F08115E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198876;
	b=EFSbREnQwsMgtkhvD2EKD4qI5nsc6N/RUSG/e1gKoBfuPNlSCb3CvFbMgzY5J1vMWLHC
	 +KcZgI6PuomFjZLN27kLVigOP7uTxmynjBsdsWCbEgm2aX0+40bB6EwgQ1QOfsf9Li4BA
	 ud00Zdv/X1Fl1Vb5CnvgivUiWfz24RxfgC45d71uR42Yb7OfDQ3fcrvkXpPWgby+uBQOh
	 Ypnd7MDCDCvwnsdDobYlbOXKY8a2JaUyee5at2/p74CfBB4bAuHk51LQUC1ZAtoklmtcN
	 npwG65PiPTSHgEWLE97SU07twQuOipL9tkBD+X7FeZqeOEd9Z/eCqMBvzoNTH+eWUzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198876;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ij4aZ76DqThFPoFIQNV8TVhSSEyz6oBid73A84miwLc=;
	b=mxsKdYB8tF7CIviTep7gwy2Rh7gZ9vvf9GttaFmebOLtXafRr8g86w45E9gh79fVEk6e
	 FzlZqy8/c5fIebRBnfnMbnkEFBTpl9YVD1FUrIo3lMqsTAaxZYVeQemvqF0YuCZ61yU+G
	 03t9e2FniG+ci7J9YvEser2IS0qeI0Mje5QqnFeHPdy0qxgtyNeuIkn/cznsGqph6eRVC
	 /uw3jOSR7sOnYVHROEYlu8ZSDRACXNF6Dz12Qz2CzWVXqBbPiLfwnKjf9rkGJvINGywjM
	 Ivgo/0TZ7Jeozf49YRbxyRAQ7Y915i/uNxBmCyzbDzqFQeA94VA1+0L18LgydMys3Kw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zmLs4dsa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198875;
	bh=ij4aZ76DqThFPoFIQNV8TVhSSEyz6oBid73A84miwLc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uepRSMudY18bbtbZDyOhEimpkhFTVllf2mMUYxxXaPfWOYgkbVY1DYMKa515VhOC6
	 pakhFE9pc773/iGpHvvt0JJJIQlK48vugsRHAd02w431FjrRDhHz9FGVG3RMu0Vt8R
	 UG0d+PKiANNhxpyNwKpPqqu4BYLyCEA4aHMAndjktaPQrvoSGsrltUyJ7/ZyJ/l1AC
	 suBBgLmD/pp2Xbq3IArG+wgy6vhyvIviev3fhA/bXbjk0KjqXu9Kb1Q248idCC9l8F
	 ZavkSe5gyzc8Ly9L8SCPjWaeJM2ZMLEaeGW/arB+UN0xLW15m5u8LD7by2u+FFwcQA
	 FV20gNn61sosQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF4F08115E;
	Wed, 28 Oct 2026 14:47:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 423A9380
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33C5580CF0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4AiZCpDz0H8B for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B8C9A80CCA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196962;
 b=sIvO09gCD3qO/mICHk7z1UbLQjCGdpwJ0tSb6iP0GXynNCbD1jSvWkQZFpO1us4xKLaS
 TDiWz+7wGNI4hdwoUz8ECs7oV10d09I5TCRH2OCbaTHqfoRvLLwdg6xD/PI4u0mMAxsMM
 OVUM0rFgOG0NoWUDDYpbVPcmzUDjj8mVQfWS2+16UkdBjE9+WBFtL12/JHR68RJU0Qd4Z
 0djGK4zemofrQMmmTMNa+vbrZYmZVf+Ys1nr0MwtXmzWuruNbvmKhPGVc0hM05G5fo9Jt
 dLzdcXQyLgqyQ5PfrlGf4A91Xo2W6Nw6EPBxa5uN9lT+6KOUDPZOSRk38sbmdi3jlaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196962;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ij4aZ76DqThFPoFIQNV8TVhSSEyz6oBid73A84miwLc=;
 b=ssqf+CkSZxEOeJBTO2BMkN4vYKqm/F30Br2111RjgMTqCMQsIis/UgvlWjU7jwTiHaCx
 nwhpeWm/Jihz8HP4ljT1elD5iZ6sg5SZfXazn6p9gYTI6muPa+m8+Trj2QmE+2+8pON99
 TD7PdZV+gtw0eD87C9pGQG5BsEdC4t6n2/1gJwbtkzFCTEdQJkdV2au3xzeNgH9P0UEJp
 0vyA1PUMtwI+To5vWR3N0/dm2qqucthT9EpK1YCWKPwom9tOjUYhJBBXskGFho13GHs76
 RW9RCD92o0Ygk12J14u5D+WKVXAkIYDkF0T/Xp+crhABdnCGWFrwyNMzciszo0FpMhQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zmLs4dsa; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=zmLs4dsa
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8C9A80CCA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:16:01 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6aff2e5b322so193954a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196959; x=1793801759;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ij4aZ76DqThFPoFIQNV8TVhSSEyz6oBid73A84miwLc=;
 b=zmLs4dsaSn2mZUOxdQUIyOo4XOAp4lAiT8IKuEqgX8MINjlyMV3TXL1AvJkDtCB84o
 E/OMjYGQ4jknPEq/c/Z0HYJ3g9Xuw8yLby+kEYU2BjhOkExnSa9rqmltqR9W27hZUEHF
 6O1CSLc+yWOcT/rwfOJV5CHWXA8k71Omg3MpVkdJgkpd+MGM/y1/Ue2314iIaxo8lVmX
 2EuwxNY2U8F0D0vwmYla9fiTMG4wX1qhIt3Dg5N8UzHruLtpnFDtAiVfguOilYfQOB2S
 Fg2o0TdjRclvtuluCzDJ04AzUiicyhOcRriY+a6dYYWQclvN+JCQdsVlpb3GKPvADrXF
 qjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196959; x=1793801759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ij4aZ76DqThFPoFIQNV8TVhSSEyz6oBid73A84miwLc=;
 b=bqYVGl1ujC5JfEiK1/u1a6YqMSliNGm+Ki7zTnx+NlvYS1Ubk6SQ8cWpoayk1QzadI
 L/yz1uQa4SeBg1Gy0S0WXiavrmsL81m8qCdQe4k2p0DewIfRDyrOJoIo2cNR0HlH4tYd
 pXkA90Z5QH6mEb3C4gQFAJotn4iB8Q6OcIX+cbHjfD0Xw+56K6FD8Jlovjj1/GvQiyiU
 moSYjo+xYiYc+oYiNjz8E0z6fiWCZ16zvRhrv6gQSJE37QbXhha3n+7piePj91VxNOh4
 clijCDefFwXsJDHupbTWuxtYTzBHHqS8N8Zh2ON0DOBU+UJdCkz8k3zvYyQay3rRy/wc
 TXTw==
X-Gm-Message-State: AFq9FYJHmPR4BmZBnPcEEI2jh8+n2SfYn859dI1uJRDqplMvmiy6ObHs
 qqOz0l7mB7st1nz8H5//jhHCGoV1I2Ll5toxL5pY3zVrsLpcbpYfNPZkmoFAfl4Gb9CtdPwPMNR
 qS5na
X-Gm-Gg: AYBFou2LbbKshgjescHAS0QECaVCyfI51lbTxgsTWvmD9u0lLP6pYGKk1aPVyes7gKF
 cy4RJCitZn6o6yLKHJ/EZSeaMPbFFPOu1QE4p+us+WCsm0A4ps/97Pg7ONqxIr6wVyVjudaKDmN
 bWXwuMh6mDhTP5dsWPVn+ZxZmJO7Ic78iJ8F0SSLvjbtIUAqRmD1z+DebC4xMQuCyAvaysdzAdc
 9PIpwBEVodK0lPi3DfAx7GDRMO3HMG83/nMSyDBvPdllX9hY7xC5gsez6JjLBLsFHkik0HbfZLj
 At4NbzaxdSNqJotclgOMVCfItN0qXN7NLNh8d28Tblob+McqPhpUVMxdHWYW+PsUxgNpBiVV3Kj
 3MFwY+1wz9aMCoqnti7ySZAq+L18IU2H8G3LtQwG0zE2/IqV8aKxVyiTaKLHG9hGhxvwJJy/off
 dr1shjIJa+on9r1lgJR10xsCndbDurwzcMZ3/nroQPcKslFzgbDerpww7uxaK6rfuNghYx+Q4Oq
 eapVK/6s049MPvSDKWdVBPpbWlngDBi26ul4SQJm2JgdX7zNWo8ThbVBlCAfP4ts4lQjsyZE+yR
 pAi5SglFFPvvjEy2bEy+SQVhE9bBc8/scOkwWRuC5SXsQ5QWQEqXychkXYTO6pDhFkXs8T6ey5K
 spNjtXQbI4w==
X-Received: by 2002:a17:906:704d:b0:c42:e6c8:e45a with SMTP id
 a640c23a62f3a-c49bdf11122mr224936666b.3.1793196959157; 
 Wed, 28 Oct 2026 07:15:59 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd650890sm629859266b.51.2026.10.28.07.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:15:58 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, dlechner@baylibre.com, anshuld@ti.com,
 sjg@chromium.org, Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org,
 love.kumar@amd.com, quentin.schulz@cherry.de, s-vadapalli@ti.com,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
Date: Wed, 28 Oct 2026 15:15:24 +0100
Message-ID: <20261028141554.3073545-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:47 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

This is part two of two. It applies on top of part one [1], which resets
the DWC3 driver and imports it up to Linux v6.16. Part one alone breaks
the build for every board that enables DWC3. This part adds back the
U-Boot glue, the XHCI and UDC updates and the build fixes, so the tree
builds and the gadget works again. It builds on Jerome's work [2].

The two parts have to go in together. Part one changed too this time, so
I resend both as v10.

The resynced epautoconf matches endpoints on their caps field instead of
on their name. Five UDC drivers never filled that in, so each one gets a
patch next to its other fixup: at91_udc, atmel_usba_udc, ci_udc, musb-new
and mtu3. With those and dwc2, every UDC driver in the tree sets caps.

Build tested one board per driver: every DWC3 glue layer in the tree,
dwc3 on riscv (spacemit_k1), dwc2 with and without DM_USB_GADGET,
at91_udc, atmel_usba_udc, ci_udc, musb-new, mtu3 and am335x_evm. 19
boards, no warnings.

Tested on hardware, per vendor:

- AMD/Xilinx: Love tested and sent a Tested-by.
- TI: DFU and ums on BeagleBoard-X15 (me), and on AM62p and BeaglePlay
  (Anshul).
- NXP: ci_udc with ums on an i.MX93 board (me).
- Amlogic: gadget and host on Khadas VIM3 (Mattijs).
- Rockchip: host on RK3588 Tiger and RK3399 Puma (Quentin).

The rest is build tested only.

Two things are still open.

Anshul sees a single "unknown endpoint event 0" line on AM62p during
enumeration. Siddharth ran mainline with a debug print and did not see
it there. I asked for the raw event value with this series. No answer
yet.

On RK3588 Tiger, Quentin got "WARN endpoint is halted" and a failed usb
write on one port. The resynced core clears SUSPHY when it puts a DRD
controller in host mode, and nothing sets it again. The last patch fixes
that. It is not tested on that board, so I do not know yet if this
was the cause.

The branch has both parts [3].

[1] part one, subject: [PATCH v10 00/63] usb: dwc3: part 1, reset and
    import from Linux v6.16
[2] Jerome's adaptation work: https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[3] https://github.com/roxell/u-boot/tree/usb_dwc3_sync_v10
[4] v9 part two: https://lore.kernel.org/u-boot/20260916123826.517181-1-anders.roxell@linaro.org/

v9 -> v10:
- Rebased on 8649a54d301a.
- dm helpers: reset_control_*() moved to include/reset.h and call
  reset_assert() and reset_deassert(). Kept Mattijs' Reviewed-by.
  (Marek)
- New patch: sierra and torrent use the reset.h helpers. Only build
  tested. (Marek)
- usb_phy helpers: x -> phy. (Marek)
- "usb: dwc3: make the core driver build in U-Boot" is split in four.
  The first only deletes, the second adds back the old U-Boot functions
  unchanged, and the third has the real changes. (Marek)
- Dropped the samsung usb phy patch, since part one keeps the file now.
  (Marek)
- udc-core: udc_bind_to_driver() is after the async callback helpers,
  so no forward declaration. (Marek)
- am62 glue: check dev_remap_addr_index() for NULL again. The rebase
  lost David's fix in 83abf9120071 without a conflict.
- New patch last: enable SUSPHY again after xhci is registered. Found
  while looking at Quentin's RK3588 Tiger report.
- am335x_evm SPL fits again, CI passes on v10.

Older changes are listed in v9 [4].

Cheers,
Anders

Anders Roxell (30):
  x86: asm: io.h: add rmb() and wmb()
  dm: add helpers needed by the resynced DWC3 code
  phy: cadence: use reset_control_assert() from reset.h
  usb: phy: add the usb_phy helpers needed by the resynced DWC3 code
  usb: gadget: adapt the gadget API after the resync
  usb: gadget: udc: make udc-core build in U-Boot
  usb: dwc3: core: remove the code U-Boot does not use
  usb: dwc3: core: bring back the U-Boot entry points
  usb: dwc3: core: adapt to the U-Boot APIs
  usb: dwc3: adapt io.h, the Makefile and the TI glue
  usb: dwc3: make gadget and ep0 build in U-Boot
  usb: gadget: udc: enable async callbacks on bind
  usb: dwc3: ep0: flush and invalidate cache around ep0 transfers
  usb: dwc3: gadget: flush and invalidate cache around transfers
  usb: dwc3: make the am62 glue build in U-Boot
  usb: gadget: ci_udc: move to the udc-core registration
  usb: gadget: ci_udc: set endpoint capabilities
  usb: gadget: dwc2_udc_otg: fix up after the resync
  usb: gadget: fix up the function drivers after the resync
  usb: gadget: fix up the last UDC drivers after the resync
  usb: gadget: atmel_usba_udc: set endpoint capabilities
  usb: gadget: at91_udc: register with udc-core
  usb: gadget: at91_udc: set endpoint capabilities
  usb: musb-new: fix up after the resync
  usb: musb-new: set endpoint capabilities
  usb: mtu3: fix up after the resync
  usb: mtu3: set endpoint capabilities
  usb: host: xhci: fix up after the resync
  usb: cdns3: fix up after the resync
  usb: dwc3: enable SUSPHY again after xhci is registered

 arch/x86/include/asm/io.h                 |    2 +
 drivers/phy/cadence/phy-cadence-sierra.c  |   18 -
 drivers/phy/cadence/phy-cadence-torrent.c |    2 -
 drivers/usb/cdns3/ep0.c                   |    8 +-
 drivers/usb/dwc3/Makefile                 |   16 +-
 drivers/usb/dwc3/core.c                   | 1762 +++++----------------
 drivers/usb/dwc3/core.h                   |   41 +-
 drivers/usb/dwc3/dwc3-am62.c              |  424 +----
 drivers/usb/dwc3/dwc3-generic.c           |    8 +-
 drivers/usb/dwc3/dwc3-layerscape.c        |    8 +-
 drivers/usb/dwc3/dwc3-omap.c              |    2 -
 drivers/usb/dwc3/ep0.c                    |  117 +-
 drivers/usb/dwc3/gadget.c                 |  724 ++-------
 drivers/usb/dwc3/gadget.h                 |    4 +-
 drivers/usb/dwc3/io.h                     |   36 +-
 drivers/usb/dwc3/ti_usb_phy.c             |    2 -
 drivers/usb/gadget/at91_udc.c             |   83 +-
 drivers/usb/gadget/atmel_usba_udc.c       |  114 +-
 drivers/usb/gadget/ci_udc.c               |   86 +-
 drivers/usb/gadget/composite.c            |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c         |   86 +-
 drivers/usb/gadget/epautoconf.c           |    2 -
 drivers/usb/gadget/ether.c                |   21 +-
 drivers/usb/gadget/f_acm.c                |   20 +-
 drivers/usb/gadget/f_fastboot.c           |   10 +-
 drivers/usb/gadget/f_mass_storage.c       |    5 +-
 drivers/usb/gadget/f_rockusb.c            |   11 +-
 drivers/usb/gadget/f_sdp.c                |   12 +-
 drivers/usb/gadget/f_thor.c               |   19 +-
 drivers/usb/gadget/udc/Makefile           |    1 +
 drivers/usb/gadget/udc/udc-core.c         |  931 ++---------
 drivers/usb/host/xhci-dwc3.c              |    4 +-
 drivers/usb/mtu3/mtu3_gadget.c            |   10 +
 drivers/usb/mtu3/mtu3_gadget_ep0.c        |   16 +-
 drivers/usb/musb-new/musb_gadget.c        |   21 +-
 drivers/usb/musb-new/musb_gadget_ep0.c    |   24 +-
 drivers/usb/musb-new/musb_uboot.c         |   39 -
 include/dm/device_compat.h                |   13 +
 include/dm/read.h                         |   51 +
 include/linux/compat.h                    |    2 +
 include/linux/usb/ch9.h                   |   25 +-
 include/linux/usb/gadget.h                |  529 ++-----
 include/linux/usb/phy.h                   |   57 +
 include/reset.h                           |   16 +
 44 files changed, 1354 insertions(+), 4030 deletions(-)

-- 
2.53.0

