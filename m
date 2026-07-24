Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7C4C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 14:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F1A660BBC;
	Fri, 24 Jul 2026 14:02:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbE0YUwc54gn; Fri, 24 Jul 2026 14:02:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F91960BC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784901751;
	bh=pisDf10TQg9SmvgvaD8dtCt0PyA78bZX82zl/s/NWbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=twO5ZZyLp3IFkCSsYUdaX/DBQIjucDec1RSzcQdIfrNvEgqUJSnWPJ7wIW5yR3rjJ
	 HQ+a2ypzd0vOfjYeDqJ4THw5Hn/82dWgjIDkwm63RCHf8NAVCeKP60kbTnTE/Qn38y
	 AH5Bzd5pdL7xBZ2tHtYF1BaJxnsKJyLV25pwD8/HVMRW+vpqI2ghGXXbOQqmgdaEBL
	 H8+JtY2xDZfRbUfO7AhsddzZhWox413BxQBC2RKkvfmabR4QXfX00m2hI43qfz04b8
	 wkKnpRIffmyJyzBgRtl/uLwKj7XBf286CLwiwIl6Ypld/L4oGY+8tnVhNJf0fAZ/4R
	 2AIueFxUkmhCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F91960BC8;
	Fri, 24 Jul 2026 14:02:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BC643347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE0E54040C
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:41:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id saTDpf6BEj8J for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 10:41:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BF637403B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF637403B4
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF637403B4
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 10:41:32 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso1853435e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784889691; x=1785494491;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pisDf10TQg9SmvgvaD8dtCt0PyA78bZX82zl/s/NWbw=;
 b=ooYZRDeqDZ2EaAtkZ1dakgxsW343X4tY6RAZqpk7jmHCn/gst9ebZSMDeGFR3FexEu
 xOdmB4NU/oZ/SqS8IcBmJCDSu/NX2oWRy07E7YzcQY+RJamF+K9ODSCtUSfmQJbvaTqa
 rL3NpKXHowg0C+298qPZz3FLRlcUmy12Z1K54lTeQUsCZZZPcslOm1/3tgASe+EHPgrY
 9mmecfCD72fdlDkUgBAVrqVmeLD8regqWMBlH4HiIhvrFRSPNlUnRQLFTjRQZmQcTMWH
 px+tMdNOaVYpUwYKUj9DkLGmd8EH85E4Kt25sFtDV7hhD4vlk+t8pplizzNvojCUElWr
 yo7A==
X-Gm-Message-State: AOJu0Yyzhj2F2gWa1L1QdK1C0OykgJOEfOyfKoiF02XBOE+r6YuvlPOV
 vATKLqVAFJm00kXq+MJrLmLVfcgUE5DVbc3R3yVzYGJe5JABt4OS/NnQPs1MVLOO7xE=
X-Gm-Gg: AR+sD13ON9UT9xCmIPLzvYIfVemPFXF2CIRrWxi2h0Qi3pbnvdBKXUuddWueDIzD2c5
 Eu77SNc7NlszNHZXAQfdzJ9xCpN/jcohnviVpl5ez3wM8xwJSEr8mVFgseCmO5GoP888s247xKa
 vYu+27XLH0vBMZR6k6Q6AsPnW7eYkdTu63U/qluKkLllK3stVuAF4YfRBfQ6k1/yzYJDhY3Kp15
 58WCOAQcLDq8VKhDLJepnEj1hhaRvk9iqbdLT0WYl0mz8bwFsGSOvKxM3PfdJwnhNsfIzIRIdcz
 krZsju1br73iYCk7ta4aS0yZjcNKo5tDZRKaS1QkLKl5piRl8eXzyq6Ugmwjoj/ViCrwIlPDJ3r
 I6hR2gS91qdVweiutpK2T3iTqyZxkY1/Midyl7ul2keWPNDRCX2Q4BXE4La9637HMy27G8KAtZ9
 FGPZbnYujCYj4E5kwhKIhe9crTbVroIlvIqhhM4+eyn+CbtJmD/MnNrxNyK7vFEntccTHjCXLyL
 jvrg53upk/scbx6aNuYHn1OusB/e6pa20HVIPNZuVGqU59DOd8rODoO7OFJ
X-Received: by 2002:a05:600c:2104:b0:495:39aa:1359 with SMTP id
 5b1f17b1804b1-49573cc1a96mr54999685e9.3.1784889690657; 
 Fri, 24 Jul 2026 03:41:30 -0700 (PDT)
Received: from ?IPV6:2003:ff:f0a:ed00:816d:dbd:9a36:8b5d?
 (p200300ff0f0aed00816d0dbd9a368b5d.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:816d:dbd:9a36:8b5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm21865869f8f.16.2026.07.24.03.41.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 03:41:30 -0700 (PDT)
Message-ID: <a0c75a6e-4987-4bf9-8936-48799972bacb@byteray.co.uk>
Date: Fri, 24 Jul 2026 12:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tpm: bounds-check device-reported response lengths
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Andy Fleming <afleming@freescale.com>, Reinhard Pfau <pfau@gdsys.de>,
 Che-Liang Chiou <clchiou@chromium.org>, Dirk Eibach <dirk.eibach@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, Argus <argus@byteray.co.uk>
References: <20260723-tpm-trunc-resp-v1-0-72a54ac30f4f@byteray.co.uk>
 <87pl0cra60.fsf@bootlin.com>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <87pl0cra60.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Jul 2026 14:02:07 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784889691; x=1785494491;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pisDf10TQg9SmvgvaD8dtCt0PyA78bZX82zl/s/NWbw=;
 b=noU8qrY9ofi4BPxVPyBoJSgZjT5Zfbb0hh29baQbGOMrv9z0NwqlPPW9Lwlg3hdEyx
 svuMnfS57Wr/EtDiX1CF1m0nd6y+BaK4WQD1oMINjHpkTTm/sbc9fqtHMcduwEY1y7mI
 yU/tWWayuNoZsdQSQI0NnvA3r3OwE7ftO85gijA7gBLMd88r1Csi2mRsqR1gMFgeRrh1
 1/FeusZsSpXYX8E73VTfZGuLg6s0pGVFrKPukuzXGKON/F0xHy+3E+C9KkabTzV+TIJq
 R+/IWl46KDL3spZG9mk2WBYyWuEq8ON8LA+bItZeO26SJBrsHTPK02n6H4LXXJvYzxSk
 5Y3g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=noU8qrY9
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

On 24.07.26 11:47, Miquel Raynal wrote:

> Hello,
>
> On 23/07/2026 at 16:01:27 +02, shj <shahriyar@byteray.co.uk> wrote:
>
>> A TPM reply's length is taken from the device and only upper-capped, then
>> several callers use it unchecked: the TPM1 OIAP helpers and the TPM2
>> GetCapability parser subtract a fixed header length from it, so a reply too
>> short underflows the subtraction into a huge memcpy; the GetCapability
>> parser then copies that many bytes into the caller's buffer, so a reply
>> longer than the buffer overruns it. Because a TPM sits on a physically
>> accessible bus, a cheap bus interposer (the kind used to sniff
>> disk-encryption keys) can inject such a reply, and on the TPM2 path this
>> parsing runs during measured boot, which is exactly the physical attacker
>> that measured boot is meant to resist.
>>
>> Patch 1 bounds the reported length against the header and, for a properties
>> query, the caller's buffer. Patch 2 adds regression tests driving the TPM2
>> parser with a truncated and an over-long reply through the sandbox emulator.
>>
>> Based on v2026.07 (fdfe2ec48d5c). A reproducer is available on request.
>>
>> Signed-off-by: shj <shahriyar@byteray.co.uk>
> Thanks for the contribution. Unfortunately, this is not a proper SoB
> line, you must put your real identity there.
>
> With this fixed, I am fine with the approach,
>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Thanks,
> Miquèl

Thanks Miquèl, fixed the Signed-off-by in v2.

Regards,
Shah

