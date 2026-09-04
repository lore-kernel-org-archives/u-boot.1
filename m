Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06D6C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:09:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BE008114C;
	Fri,  4 Sep 2026 08:09:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eyACnrQQNC6c; Fri,  4 Sep 2026 08:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 75F0D810E2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788509382;
	b=hu/l71zYbuRF76T7N1/z89WMKWhgPTkFdwEjhCOfh49FG/DfRNnYLvB+GCsZMsl262B/
	 cRhj+jq2oyVPQFshLQOc1Cf0AjeFBGIhmEV0Wymbn28leSqJRBIrhmvRtMXvroCzvbKpO
	 cFAs1gSIXyeaPKt+1Y17tmqeSwLN1euOh+g3qbv3RMPpq7juM1NVmWxtW/UCMmh+zDlEo
	 LpOlW7WtkQbFa3zjxwQWiPW98S18LkIXkUhg5QkvJN+X7v7l9wjORgRCgJwJQ2s1x37B+
	 wzZZPF+dkiyBfKEomICeThQOrEBIkutFLvmqO9j4Em/knsBUj0L9LliAHV1e1OX+h1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788509382;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mg6EXHhnifwOfGJ4/dN8FObWNblwSI86dtfcbY3Js/4=;
	b=YCYdhdDG8PdH8yNpGoctOBnAIfP0ix5nzlHEGj+LnELYr7rDScga2cCxD+lpcLr0UUF/
	 mpacGlZ6MfGpiJk2SjiBiKVW15GigjbZP6t2YLslvOnzLbf/I/soFlTo6280/KYeMrJI5
	 hHrBnIZ6Jw1Onbr8hVHEcJIIkK2Wxo5waCinUVxM6B4Rx6vxyyFApRO90fKvOQObC8QSS
	 t5m1nYLRE1TIBVY98t5TwLX3ZTe64l9EFLv4Eu8rkOZp7Ew8wYIpzPKvZ2KAi9cJlPlPV
	 BquZHAbyKEh2xXM4R/bvRgoM1h/kFPglWRDNpOy03er7C0ZmjBpwgsiSnbVHVIdYE5w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788509382;
	bh=mg6EXHhnifwOfGJ4/dN8FObWNblwSI86dtfcbY3Js/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VivXhSMLvAgFg7HqCMQw6oYrEDgKTI20DV2Stg04BxnlbtkMx7/HdAlQOIway/BFh
	 KvEI0mhN2/DlyopaWcHdebPnIu1J+sIjGvjWtpF0qZmxNstL875yYCRVJI0r5WBj2r
	 HoIQTNx7QoLEObSOWlSi1RH4ZLeaXs9Rso6SQz1nYa+CXAxgU33bzNflEHSxpVkycu
	 4lIwizhIjTfmdx8iC3VC+wAnLnedYkWgb7NkZ1vGFhJjL5swaBj8wbZpFwSXnmB1dR
	 IswSPUeSl0IhhXWZe1M8gyHIR8u2xZouGAjHT2f+5em+ZsfnH1AAjT05evw0QiRAW8
	 rELxqzHmMPSUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75F0D810E2;
	Fri,  4 Sep 2026 08:09:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 42F8B2FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:09:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 346196070F
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:09:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3q9REFyNCEq for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:09:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4BF54606F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::629"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788509380;
 b=WCsMv7RMfxeC/gVqSbJqrGHiel1tJCHr68/yBd5SJ7NsUIugQ8xnFWip96b90mnbfRj1
 /lzmjLJ6ndmMQvJhT44VsUzfqHgvLk6GdaB+B5Ok4vbHxFPurRKTMP004KL9HTZaxwI0w
 9o2ejsq4KrdUd2MqB4uI75aRj6bSrBJwdXckEs74kOTguIiV7ZItkGzlmbi6enFxaQHYA
 M4sv5+eaFY7YRMMjQHvqbtDS6WfZadUwlWA8eCnZt7aGHgZZUJoSvK1nRlpDDp5/o52AL
 qkxHpB738jhuyazHwkSop4VtozlKklSgHEfj3FmarexmsA8sjEAjLujmJuOmYZm7bQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788509380;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=mg6EXHhnifwOfGJ4/dN8FObWNblwSI86dtfcbY3Js/4=;
 b=MueFu6pi5ZLxhVLrxjaTCCwZ4xIqhfSOz5n6tgHc4uKtYVEaRV7YnL8fe6COXwGnNl9M
 xS6eMI36WliQGK9BHbEh0v8u95783FqXsGmGVQW/on1zKigDhfViymdPEh/h4cmf1kMYB
 ClnawMoahUcIkoAQLIh+mMBkM5G7BYImyu4o1LBpsR1XXNPWAMLs/2I2clurrJ3xmq9jM
 R3NETgbsuW6ZuhBlaw6MZooTrbbf51uy1yFOX5FTYYBFWTdo8MdSz1XzMFNT/9tNc1Foi
 +0IG+Qsv/JXaqgnprf6iAcc8p14XBcNygw1YPuRnswImTJVLT1w125bb7oIgZ5QlBQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OkI7jKKZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::629"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=OkI7jKKZ
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BF54606F1
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:09:39 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c2544ff970dso94242366b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 01:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788509377; cv=none;
 d=google.com; s=arc-20260327;
 b=O2DCU9iTKlU3u6g7m8ivjomzYw3g0j+pvCZ1syuIRU7TFu3Kpps9FySppHgPPqLFtt
 kAJ4n6iW51hAyWqeoiEuyFRe4X9EP8GHUkdAAaDz1fXqLO9sNrjuSrQDLgO+kQvhNKfZ
 ysfF34RQ8FGm/FvKuwmwbq2BdHYWYcVIzICNPWvl342kqnI42Ht6nUK5fnmsfkiLegzS
 Y8EDMW+0HCTVKqlXxKegcFkWs8k4IqSzuY/2yiUfWAhvS7zBqToD+0bJgiQZoHjz4YfN
 Jq5On1+nh+Vl/X++K7JEMi/u3yjn6LDromuXCe1eJfw9WXmtNghu9V6mZbRYATKOz77J
 9c/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mg6EXHhnifwOfGJ4/dN8FObWNblwSI86dtfcbY3Js/4=;
 fh=/ExAnPSEoQTNVbqLVU5b3GFMyi6P/1TqXnkyEQN9YgU=;
 b=m0tfkOMsM+KnI2D7iW0OuL3vaBP6JKGZlymniZhCAbweRmiVG9vPXGJ9M6bHWpuizc
 S4zmrE8vgTUqbrTcv1kyuYwflMuQnI+c/0LTOkhUsLDncriarg175xM6cjVUSY0S5MTW
 +FrfZLBhNcnMdSy3mWTB8WdKCwQEW9HergEnDLnAmazR96KChI+qKThgvFIUxmpgaREB
 BBaezp5DUg6J+CN4MoyQ7eNuRs+VA5qlExvqmz7b+Tt82yNCi3veIWUcWtBVAa4Ey3Qi
 7o1ThR8xkzNggy4MCe1uhmYBz2rx6/INLwZ4Se4N+SdU8AigplgTXhwfclCuDcmQOX+6
 5R/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788509377; x=1789114177;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mg6EXHhnifwOfGJ4/dN8FObWNblwSI86dtfcbY3Js/4=;
 b=OkI7jKKZ/LyyCtgDihbQCRrqdxs5m/r6X77o61RvQ1HTQ6/oRiB0n+FlTPKv5qrv/8
 GSsYer+voHOSbSQgzVZFjfhzi3nW8T1tEy0HlyCrNnh1W/lSdGmyQy5Og6Rfzxn11sra
 /znWq1fnHEaKU0lqLfez2b6aUUVPPFIKkwlM1LOcUn4prqokpzA4xjYYzAqzGNBurk7e
 G1P5ePLcY0nWW0JX+ZngwCnYgoZO2TGgE1aZI38t7ksac+5ULhH5SbBVN/zqpQOelV8p
 j9o9Dq+8EMJioFlgBWlv3UsazesklW+z6H5STG/QaA3trBMpaJTg3Aq/csm39AFi3XPn
 SQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788509377; x=1789114177;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mg6EXHhnifwOfGJ4/dN8FObWNblwSI86dtfcbY3Js/4=;
 b=WJ3DSYVNNhOer450zPmcDeslEobFHGRqm8m8IMM/0beXvNU2Z3QaVm3NGGIwrZs11V
 n/dzr21LP540xui2GvDVw+cTtepVnoP0OPbAoo4t52Kz6Wyw0QWjJqelb3XC/jZDPDeq
 LwhyvEzl1O3d3TeBa7YWRQSQkHca2xlNOWHZjMTRWLEqtZg7AFG9TZm+rnt5gl4oPO3D
 O7IWmMNLU6a4ka+qFQGK4oIlObBUoOESht/fF9b+BoMlKUV/QAcGWPk4cGbKqLu0w1Re
 ZVwOoD14iR9weUpkrTjqNep+nBdWHwmOZKpdxEPINt9dA5VMD6SsyLnGTkpwZeIC8Oum
 U24g==
X-Gm-Message-State: AFuF++l0SDWKNdvyPUxSUccRCSZEeF1l3Msnfhb/GQoZnUyWiT6Ercs3
 KxmuTGWKPOOFksMV28OZ/AbrMQ3Qs/smTCTcSgVx9upSanOT3dpJZYgE944Lqsk02miwFPVVkY9
 FZuhWYAa6lJ5Tk2a7xtbMlzacN934pxQykLlf6hZ2pg==
X-Gm-Gg: AYBFou3Aksr/RVLm8romuLUDN3lkUFZp9CnIE1nFCILkqcBKy8qT2L2TqdVZmVDqdG0
 PlnZeHNhEG13pWcy3z+hHcYTMY8PazyjIcvgLFll1rzCD9CqpwwWKo6p4+S+d0EtJfkCbfFT1nW
 +sB6upg8Gw8aVxltNp0nl7WfcfxR5BuzKjr5X2xF9k1K8eu0MtuGvKzcNTyTzwg1iqVZK53jmJm
 WDY5rJslo6eGBq+0IYRfo0wYPbra9arRJj0Og/Ot6XLcZ4aywL4sivTlXd62gQu4pJ9U8nQcjCp
 lbF62YLjs3VY61mwChyKkZGMdvRAfRnZhve8R3ZMWpSiuWcCsOCScL3649P0XA6iOApZcsCLU6S
 UTPPPJlA4T80=
X-Received: by 2002:a17:907:1c22:b0:c26:1649:47a5 with SMTP id
 a640c23a62f3a-c26164955efmr83563566b.27.1788509377375; Fri, 04 Sep 2026
 01:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
 <20260904-ufs-spl-boot-wlu-v1-1-59aeea16c4de@flipper.net>
 <c850c6d5-2413-4ca6-aca7-28401bdfd18a@linaro.org>
In-Reply-To: <c850c6d5-2413-4ca6-aca7-28401bdfd18a@linaro.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 4 Sep 2026 12:09:29 +0400
X-Gm-Features: AcwNN1Wcx6shSDqFLu5u0ndzzid7rxiVHKFf_hzhshg_u-SdNfG8Q2TTGkZsx54
Message-ID: <CAKTNdwEA+W_AYewLuactBdRvW-9ww4jacSBjkppmFgwGex8Dhg@mail.gmail.com>
Subject: Re: [PATCH 01/10] ufs: hand sense data to the SCSI layer
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Sep 4, 2026 at 12:01=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> On 9/4/26 09:12, Alexey Charkov wrote:
> > A logical unit explains a CHECK CONDITION through its sense data, and
>
> I'm not sure about the "A logical unit explains a CHECK CONDITION through=
 its sense data",
> I would say instead "A logical unit exposes a CHECK CONDITION through its=
 sense data".

Thanks! Will use your phrasing.

Best regards,
Alexey
