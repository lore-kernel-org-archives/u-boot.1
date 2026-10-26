Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9D606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uaeGdofL;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=HTZeGj/X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44EC140519;
	Mon, 26 Oct 2026 19:20:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NTjrKiaWUMN5; Mon, 26 Oct 2026 19:20:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 98FC740514
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793042409;
	b=WURao//01FsGCgm5Q7tf+1SfytxzrgK8+Bch4qupG9btmglh/Vuw7XPHzRCB/Ld7FSUs
	 3GOOOlyJlhOjqLW2RX9STR6xFzs1tuXe68sV7MBhVBkhj/rxUhJyEfDwwgsk/aHzguoFO
	 bByW6I0s79SXLuPao0Zy7WOvwpUsmmBDf99YXqRndaX/axeaJWsw0er13jyLr8UmpEI6h
	 exR33Jl6NFSTnedBHxn5sGdWRk82kNnSSVIC5tzqISdK8p87Xxd1YKZSYlAfxSPvQafl+
	 qC9Y4Q3QX4wP0mJ0NW87mmOsqCUAGXpHTLFMQle8cq0kialTAG6bCLP8tXm3m3Y/X5w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793042409;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1DsWbCL4nuLm58z/KltPIknqq9XZnLNDiznOmLKtN78=;
	b=GfkgYTASo78GOJzvVyFujrD6F6H+RR+MVQx5EkZSGg+M2wAY0Y5URuzKR5AmqOL0Y/wV
	 psHZFoPnpOcaDKdOI6NDviE8fPHTM54AuB23LK5rTnmrvOlMb2Cw9wQ153EcDIVb+06nI
	 7DEjinneZ53R0uakVXb3sicGtVjghKW66DDPeRosgr4rEX9OfQT5WMBQsvEEoWngUkWZd
	 h4q0wjszTguYU8Q+WWkEOPwyJEyVNDMtSqGzufXIvRfL95S+XR2Fcj7t4iNwcPQfghKTD
	 Yic2DSLAS81LI7tQRGKrx8w+E0SJ/BzFpgATiXkOV4q6py1gU4qU2Y2fdHbz8i5sy2Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793042409;
	bh=1DsWbCL4nuLm58z/KltPIknqq9XZnLNDiznOmLKtN78=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uaeGdofLfh0aDMbhz1ViBpNclDogBw8qEqWktNaRh4QSi+cT+bL9z5Yu9+7CFRfiM
	 bcgQBFE44G90rI4+qGcZQaKlSk13g38HWEG/vwqaP6S7aNGMRrpoMyKd3i2w/UkmPx
	 kL1FLNqcKNNw+J6LGCxohCQiJkXYhs/Rm4dXc0dB8mQV2JI8RF5RelIAb+VIelw8+/
	 uR71Xvw2/xY2mBwdXR5opt/eOmtfPC1a4esuL/DLN6tNZLzWhKPXT8DqN61blVZ7dS
	 F9n88S6js7A4Mu05lA3tz9xmeoLrajwr2YKqHusxBcB3XRYnEY+X8Psbn1xhEYX29k
	 tKnXMERifwVVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98FC740514;
	Mon, 26 Oct 2026 19:20:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B3BED2F5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98F82807C5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:20:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8_PplW8OMApl for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 19:20:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECFE1807B1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793042405;
 b=RUa123u12QpvD8MwnrmrW1EHzgi07XUwF+X12NoPFEadxEbgrRaCxfDaI0EVwuNhNGjX
 CCivEvZ7jvZ1WBpgdDGJiINKKiOzIA6aEEjEWCRDMdzZO+H4xwkhsVL8r/2g3TTyrwxeu
 2fk0nj87r5cohRAfa6T8o1fwoc3tL7Jn03Zfki54T9VlsOl+YvjlbEFpuy4ezKmUwTyDF
 HMvYgUOWJu014LxM6GZu+lznRIubh7QlC9dZWE7oTm+yq/wBwr+7nulCGrgBeE8ejh1Hk
 vfWllqtEg1zI41w4Oy+wTKVA4qzDN54ov/wn8NfRlDK4ai2ZiZA3tjZaOKAnWj19QCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793042405;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=1DsWbCL4nuLm58z/KltPIknqq9XZnLNDiznOmLKtN78=;
 b=ETyGs2APEQefnWG0jSHkp2XIsIUwvt8AXLjd8UKrZxdtwLwujTCQtyIcdtlZrHxvBaAn
 lfAwZhu+cJwSr8h4MBpp85FG9rgGZMwLnkUAs6QzJCWuwDp5HYOXPDPAQUHAwy6pzDwwH
 14UMdpsZEn4iUcqHQgTDN61AKr591I4Ue/3Wk0eDCta9u9Jj8IlK2Ijq9sguGb7ypa6JS
 7raNnXfAiaaMOI04NMfHDrZWx5L/tUnLh2lxOcxMDZLomvAAqrFzarwtXCyRsqm7sMN9D
 NBvTDDMIC/03fsYIigxa1nAin2tglLWd0Mnd/nSob70W8xz2NTa0dHiM5pDLyKwNfZw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="HTZeGj/X"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=HTZeGj/X
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECFE1807B1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 19:20:02 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-83bbcfba0ffso2375544a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793042402; x=1793647202;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1DsWbCL4nuLm58z/KltPIknqq9XZnLNDiznOmLKtN78=;
 b=HTZeGj/XdWUH417QVBZ1AI/0h+0L84CZUpuXykQWD1F6CsHeX/2D9G4iu6Hj7cg6Bj
 9mtL8WFV/r0yjgLMRaSvFAlXDHW9KbNiiFweU69jVpW3QMU3QZvq3d7OJA4deArcg3rc
 7EOJ556EtnhbjmLdE3EFHmjzUXuliUktRgW9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793042402; x=1793647202;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1DsWbCL4nuLm58z/KltPIknqq9XZnLNDiznOmLKtN78=;
 b=UBO4R1O5JZIt3EN2S9+V1x97jQ9SG20Mexd3e2G9/gAcHqpf4HpTKbKXMG3KtLWJHK
 YIEcMXxC8ZApZxKGjDzO37Ghx7KDHgrn9jbLysyH64yizylNUqAWEt7i/ThvN7Io6mG5
 GhdkQdyD8yX6WzwnMmzT5iAdlfmotW03aBvZ8Lg9ZprVVT+l/cprQEI8mxztJU21r0EB
 CxTrfomrxzteBTA9DXef1NgcCwTXel57jK2e2msPd4sdNkyZIyRK4450Lb+Yru2l92D4
 UcAOynhTFiu9EDEB7me9fyohlTMrge+vHBnFm9YcQ5u09D28+9e/nW7V/+fuy7CkqVIj
 vkPw==
X-Gm-Message-State: AFq9FYJ0fDmyGLUIlMMkhvFl6Mv2GCWXWWirTorLYoVuYsicX8XqB6G4
 NiJGCGAl/jdPUudHdz8JWB0USMjAizYSSXYykn+GYqvk2yzYPSXkYMsmkw3zebtlDxM=
X-Gm-Gg: AYBFou0mmm6i123LucLZsfTPfN3VBy9aVgYYDrdxHWNzBsuoClRjFdjj30S/B+9TWWP
 mFSKslPXSDgv4yL9p2pYnOZyVutxWvZcLKtQZwC+aObFGhLXKp6qPc+rZyzxIH0cABeTOTSemh2
 rdwkM/ayeWMiLdb9dNLwHTKC3q4NP+5s9EF+PTZZAsXMxb2MRVc+QfYJ0QYjXAr35cqABkP/bNx
 x1YpjqQkf8v27EKcQpuUVKiDLGRjGT9R70wcZV3+GbmMj72g+tpRlvy3ogLm1zs3XxQ2lTfzb6R
 PeOcAzjtIUviWzkBZ3Yc5qJpFwMP8peltuciZllXVZcBGf7RmuhYkwcnCaRw9cfwj1+thUDoETU
 ZfkBnXCIo/BDb9uu19ENEQvVlO3WSsFQggkFEo+Xdc++Q0E2xw3O/R2q1Cs4akBTVraAAvQHoxj
 e2dlPbtiiRX3T5uAT5btswmLOOenD8cf8sACXqbyYsEEXlnTlqjS+UVNeRbhZcT/qmhp96dL7EN
 Z9iBbcMcmpOLoj8+MGcMydZcatYJ3YW0firFAdqwXkyS+CS/n1D67g8C6xkK15YOzqT5CNtgi//
 smE00m/BaM3QKDvHyS7iapA62iVs3rzlFYEZte+N02IRhDzq4lUjLX6tR14JClkZPMRJ6uPDDih
 lDgHMM/hWcuAEWqkEWHroZ7esvntcxAG4EmRQd5la5MfeaNdCgHYfHLZZ
X-Received: by 2002:a05:6830:719f:b0:80c:d30f:97d with SMTP id
 46e09a7af769-850ff7789c6mr5839663a34.30.1793042401883; 
 Mon, 26 Oct 2026 12:20:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-850fb64a8c4sm9539404a34.15.2026.10.26.12.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:20:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@nabladev.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Jan Kehren <jan.kehren@emteria.com>, 
 Petr Hodina <petr.hodina@protonmail.com>
In-Reply-To: <xhkdbbj8g311o.fsf@mkorpers-koolstof.csb>
References: <xhkdbbj8g311o.fsf@mkorpers-koolstof.csb>
Subject: Re: Please pull u-boot-dfu-20261026 into main
Message-Id: <179304240053.694041.16334889933044459564.b4-ty@konsulko.com>
Date: Mon, 26 Oct 2026 13:20:00 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 16:59:47 +0100, Mattijs Korpershoek wrote:

> Here is a PR for main with the following:
> 
> Android:
> * avb: Allow other storage mediums (virtio, usb, ...)
> * avb: Add lock/unlock support via OP-TEE TA
> * avb/boot_android: Fix TOCTOU in bootmeth_android
> * avb: Improve pytest suite on sandbox with dedicated mmc12 device
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


