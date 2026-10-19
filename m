Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB24CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FEDB81131;
	Mon, 19 Oct 2026 13:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDN2DwOduzcZ; Mon, 19 Oct 2026 13:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79535810AF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416468;
	b=GM4snoCtpDfY5fK6BACj2iYb+Y25tkd9YesYfs1T5FEpd92Q2HPx1AuA8mlXBrEazkG3
	 z8P+EYk4SEFt//UqBNk4LdgpfiSeG/4xtjn7/v8XoHW7fcHaQPlaFM+Jelo7tfUT3M+c1
	 uaMNZzDBIsdFhpzPncANepossuZ3blyjdXGYAXQBGSPJLj8JnmpXM49nET64ubJR5YCfK
	 OHBGl/4uR40Eqmb+VIBLUG4wEa2O7NjnneMpbT5MTS0POe0rn+ZB6GwwKfZFLjm+LKDRw
	 SBan91G0+8J5Lmy4g6XfpEHaFjA3xBRZrOq0R+4i18p3/UqYtCTf/LDGAXoWvIKA/rw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792416468;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VhyC9NVOGIhn7RYaFn30Qf77rWaIoT7BrD7I88t4t8Y=;
	b=gR9tyoGBbdW6yvtE5haPaEIcF4pdf9/eSEfZUO77h72gRHZS9K/K4ggwpa3SLc+hTznO
	 FWGUn62AlqDGmu3gjICqV50Q0g/mR5TGxgX8hJErualLNMJp7wvYw57+NoZFLbt/smg8/
	 cmTjXqL58GDFmYzPrNzyq/IpQngCJGebE5GpfMBPxr2UeC9RvuD1u6PV12ZOFeN0Mt0Ho
	 PszWd0ZifgaIAM3AuCY7XqPWnwdEmCzOp8If3W7m7cdMDQFio1IrAIWM9Ce8RNc6WCUhC
	 DF1qSUKiDlfGQGO2DbB8Z4C2oDEsgIMGNwvEhv7ddrCc8LnFZRyNAEh1PCxJAeNiYJw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=I5QUgQZS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792416468;
	bh=VhyC9NVOGIhn7RYaFn30Qf77rWaIoT7BrD7I88t4t8Y=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0BYQgLJJVcm3Tv16BCdbPCUXRawKQU9BDuOF1hrHEYRFSOyRPaKA917UyaHrTX/HB
	 y2kiqd2xls5qya06DMtkowNUDaBdRYmGaFLMReazhBE75PB0NhlrRMVg/GymM46mEH
	 N0x/Lbilrr4rD3yulHwkeoIiJTo/oKKlLYJwnmXnhsrtPD9/J6C/Vt3fOP1Cf6Zmk/
	 l8BWUkuAKx8h4S8VQEpJ/YArRsqfGKPHaejloexYafbYaE/E2CJ4YVi9R/yifHDR23
	 qLw7B35Hd879bonPhoIZqSti3Qcwrf3TRicF25BU/YhNp20va6FldvQnYBHtl+PHs9
	 mw7WpN1G1mAmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79535810AF;
	Mon, 19 Oct 2026 13:27:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EE2361AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFCAD81100
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qMAQgjgwpWUB for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA6AE810ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792416467;
 b=KES0sBzfsP/yh0eSPFUlDEdkE+MX9H6EQt9Bo6+jKl00iQpd2dD4N9C6kw5sh3GOOeWR
 jQf3F95vxe3emOs7sBscs0zRIG/ckJul0FxORUBDx4VM0VnEAe3LosEMbb98bMyo88eK3
 nOQUSfwFO8jvQfqmm1z5kVWDm0k/NclowvLpZ24liKi9EQNRHdDi6NYj1Ce5TSnUMILzY
 PDu6J9z4Ov4aWjXbGGSlNSGodAIxY/llGOEADW1NnIxobrhQc9xvhl36aG8snflWOcatg
 LuAtSiiqy7A7PcV5KvhY6F4jeRcgDlfCb0LhVQ0zu0ZEkq2mX33ncR4TokP8jsH9RQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792416467;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=VhyC9NVOGIhn7RYaFn30Qf77rWaIoT7BrD7I88t4t8Y=;
 b=PWpGek3KFX6lPOtB9ZIIyN/sg0aULWpYK38240Kl1UryJCPMscQhiiRqdbFmW7kwXIDK
 ikX0steVWfOkF2zRNe8n8DtHVmRiDrOUbBxlyPoGmm9raphR0p57c4rztkduvqh9s31Cb
 2zB5tvH5i9m/REkDRhYMh5O3b4mI4PCeXMiL5sUxdqVQZwLaa74HhML0N9nisvueQ10kN
 4f6oa8H6+kyXg6ukuTFawb2q4csB282BF53B9ap6CgqYiE+4/u/vb8sB0gLi2vH8x6Z1v
 7y/wn60NkRCAGRwol9BbiQKIuyKfV8HVv2VPgXY5QUeg9GRPKiN75ecHpYJlT/YKgDw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=I5QUgQZS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=I5QUgQZS
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA6AE810ED
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:27:46 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso3342135a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 06:27:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792416465; cv=none;
 d=google.com; s=arc-20260327;
 b=TOYWJWkNgj2/WIA5AoYdLx4mjk7zlgq1FNXBHzVZRoZ8wUVGh6ifOr8TvZrD7Cw0KC
 66RU9JeVLWIL2+3IYSJLtWm09Fd0KcVBdQ/upItH9ZWO137Dyra+l+qFYnpxgfe6jFfH
 5y9zhyHT8BF3fveA6g+wETCeGNYPUKsUZSnzK1iTsbb4PieZXqJjN7R53P/a1jNR8C5b
 GHrL4rOtiymkgZliG52A+N358pHzFhe8CMkOBvQVqJwVBbeOGYXRj2vrhGHrrUH7oST/
 CSMaST1YU2unDVIhRp82BHQKlGyq2Ebl154PXISHPYhmtXS2MBKa8OXecimvF7fj10Bv
 TYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=VhyC9NVOGIhn7RYaFn30Qf77rWaIoT7BrD7I88t4t8Y=;
 fh=WciFJU6hNeho/pr2KBfYcvtX+4otJIahMsDMZQWppHA=;
 b=JX+ah40YzihCoM3mpZGonCLncWvXDxeZxZIZkMcbp78Xu+xp1ijNyTWNnugo96Y2+i
 +IGdtUAcgk02Zcd/yCUdZCLn6yA9djmmq5wO6C7HKo95OGyTtAcz+vbibUD1sn4K55zF
 gWBmlZr0gZaC+ZY0/mrTzpuLllkfY9D2WZNdLeTRLnrjtiwonCXjjsdgKQKhPKQMfFli
 Vf0dUuG8QsEks6G7oYYbvfqueoEuil8QuMu7nvOjva1UcdEDEKgm5i3g73mpHr9z5vP+
 klg9si16IZUaXlZfsXq6sYkE10kZcV+k1iRpq2oIJttaDXIilqQBw5Y/xQRv4l2vh9T4
 f3Kw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792416465; x=1793021265;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VhyC9NVOGIhn7RYaFn30Qf77rWaIoT7BrD7I88t4t8Y=;
 b=I5QUgQZSoi1PE5ZlyIFzmqJcEupMsFDWUkahZukKxoiH17vpTVAOxIdl0SGKziuhwV
 8diWUU4+HG9B19amZl03trMDyUjqaA/kthV3j45ZW/8lgDFtjoi2DF8DqtPdxOm0eVDm
 qnoKehpU4RL9PoXG0BwK6aWWioenW2yiUMpbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792416465; x=1793021265;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VhyC9NVOGIhn7RYaFn30Qf77rWaIoT7BrD7I88t4t8Y=;
 b=gT9n0QgwmxjlDx8Tv5CBu8V4Ce/jsWFWTbdzaerWTIjkGZmaGy50y9L3ofY16GufoF
 wYvl7RjUC0ansV21vkp7wtYDogOuQfPNWYnYz8uNUIS6khp25JmjN8kVGRLjgVWKQ05p
 iL7FsdxT7yuOHlYqApLevGBP41lYOIIlRwuZb/BqRqBoOTzNTFIE98mDlbMpoSD1BhZy
 UZHVF+llT7oL7rr65L7kDC3kbh239k1cbVMM5XQFNC89xyauw9LkA0GD8nyo2sqH9lMG
 nEkNdbZBeYIEy7tQxLiOYg3dSgKvWeR9H9VdwcwsL1A9DReJDrc+vODoZEmnKBegT3Jf
 kU1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwMPvbQWZ65kcafNla4FJDjXMWGpdu9uX4DDullbguAcWCXpfoqPWVq3tKuApUgCovFGG1XAPs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKRUx3kRIct1nZ/i3Jw7M0Mv+zEwBkAQ6ND6lIkt2B4yFPwE/Tj
 VK+dEdaFxcWY0SjIVYH5BOBBYWrYI8Rc0V6pXFqBlpEmlE6sPf8FtVJf6ECR37aaAqpYZE+MJyM
 i4sdP+taStQc2duG+BVJwDNcUxporqgUOWqmaAjho
X-Gm-Gg: AYBFou2OBy1alrfAZAax6EjWsLELkh/VBP7ydQIsdwGlBesFsCXBhgnX3pjJ6gDR5Qx
 N6aDixq7lwRlV0YDCp1gTTIdRPJ9/g39H0iQk0xTeOPH5b3ULsinyG/3nmS5c7nbCu4xbGWN+H5
 9kSB7dMw/uLAy52qmb8MYmJhFmf6STIlNLLQUt6YcJrhATRIJo2nhEByg5J4ioZIdpyKMyQjajt
 dW5Itb21aQE9s2RGku2VZvuW6NB6rMUrMUpWjgDyuQg0tHgcTOxGh0KK0FJYli8LknTbm611k1E
 UpHOqae09lYU/kxL9BK7sdRn4MZFMAXYox/i9QyViUr5s0oMm7wRykZEViXu5sc4
X-Received: by 2002:a05:6402:510e:b0:6a9:9a0e:e05f with SMTP id
 4fb4d7f45d1cf-6b3878132e4mr7952922a12.2.1792416463226; Mon, 19 Oct 2026
 06:27:43 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 06:27:41 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 07:01:15 -0500
MIME-Version: 1.0
In-Reply-To: <20261016040216.3636305-4-visitorckw@gmail.com>
References: <20261016040216.3636305-1-visitorckw@gmail.com>
 <20261016040216.3636305-4-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 06:27:41 -0700
X-Gm-Features: AclHuK8WFI0Axqp0JVZR0XzAIyyza2QValtrKFJOklr0tJYqsHNdNGrdRj7WFm0
Message-ID: <CAFLszTjOvVic1=Di6vss9Nbk-8gL68Y2Et5_fpTDDBSWPO8XKw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm: dts: lga: Enable console UART in U-Boot
To: visitorckw@gmail.com
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, marscheng@google.com, 
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, u-boot@lists.u-boot-project.org
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

On 2026-10-16T04:02:12, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> arm: dts: lga: Enable console UART in U-Boot
>
> The upstream lga.dtsi leaves lsion_cli16_uart disabled by default.
> Add lga-u-boot.dtsi to enable the serial console for U-Boot.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
>  MAINTAINERS                  | 1 +
>  arch/arm/dts/lga-u-boot.dtsi | 9 +++++++++
>  2 files changed, 10 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
