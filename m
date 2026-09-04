Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4749C61DD3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 01:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4EA60607F5;
	Fri,  4 Sep 2026 01:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oduaHN9u-6id; Fri,  4 Sep 2026 01:30:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B808A607FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788485427;
	b=rdKCN9IkUoDdk1Vy4kCUoNZOP+KSemjxihQYM39CSpvfRsvBYytBUiVTkFycw54h9phQ
	 BCYpM1/MnchNvLDltzn7JsgOnRolQRGuCekipupSm2sJic5NWFFpvWcym3MMj+y3ZVwch
	 L1uBJlymgQhOOZLLjIkx7u13iZo92qdP9wenhwLqvETnJzV4MK5dUkoxzUP3gM3hnNmHa
	 AID801rRpDJwJqoitEwxYdBQGAgyiv6DtAZ7wnKvieMSxh6nppfh1wmrNPzlNwIGZn2sp
	 g5Az/Vm/HNzt3Q5BcGLJ1frJNu4iGTykYViXduEbByKaALyl9CqNyGwpWp+FdXrertg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788485427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zxt1p7Le9HZ0zieAHawbQivBc0+yCY3yAKUadNKeE3E=;
	b=kC5xikdEzMlZYrpR9cPQwU934xSkeDBigXOivd8TbpRBdNkKisneY94WTmIN/19sApTR
	 MnM0Pq8zSlWdJDFV6dkJmjFlExac5T3qsSVXUzC5npEeKxVJzsVyRAzKVUF0nh8KzbRng
	 WRjvCKs2L123OFnq//Ca3kFlmD1aZ2S4J1bCzgd2rXJotTiFsSiH7rzxTM/YxV2qmUjGp
	 w/9IUwGeKhpYh0qT6ygX4KSYCEEKRvZ7NW3mu++bbakV4xtZbObuGtxmkUnzw2DetDSsI
	 su4fmWHC1Ma5z4CTkAlh7CDSLmkPZjX33tI81PPQMLckC6hG/At8cIvC2LXnayIcUVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788485427;
	bh=zxt1p7Le9HZ0zieAHawbQivBc0+yCY3yAKUadNKeE3E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ea75vYrtRs19Q5vKuAEuI3JXTSR7h52gumIBJbCKEVF4MmeqkoRYvFw7XFPyvIPsZ
	 NMmK997KCSzbrY+3I9OKwqepINUr7ClwwtaKS9PS7TuFSL4rsCDV8aMp5/LRQAwshE
	 1oeXUKqhTY0pK+b8pXnb+y9v9aj+NyIXnALFzXM/PopobqBfnsJVJIuic30kwkJBsN
	 +NhR4cayzAZSADhj9sx2CLHcbPwRfWyWvl+tfhOqdDIYbuAxOcoA+Kk3qZT9ULrVF/
	 8G+YVsxjKsnkk9IW+jaPezS+mVtrd34aTL4nTa+/pK4Ykqco6fVUraSyULegvn676x
	 oHEf4vH9f6f4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B808A607FF;
	Fri,  4 Sep 2026 01:30:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2303410E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 01:30:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 089028114C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 01:30:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GevfYx_c19Yp for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 01:30:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2C3D98110B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788485424;
 b=NCydvmMKUepDMjcNsvuuw8jr3HEIXQkwB8rBdkdZZmwn9Kxsd1FZiVd6dV8Re5JrvldN
 lJiOlU5IAjfJ9/6kxINN7T/i8vx26bMO7EcGDeayWadB4zoSxZSjdV6Y+qF+hpcWyH98N
 P/Mgx0YYCMTBHfRcJ/vGx8H4MOJuk51yahkGbLpKbhLSRGnOHg3sLvOJXfHzh2RCDMPh2
 bQ/c72dROGceb1tNUrqWPksjh3O/UJdr7uVZFQXVCF2oCTYKaokrZ7kddSB1XmRtrsHWW
 ovbiXZVAummAP8HaaC2IYLLdFbk+uvwEe5rgwl9tOwOdXi9+inzN3FSgs6NJDz1pCwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788485424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=zxt1p7Le9HZ0zieAHawbQivBc0+yCY3yAKUadNKeE3E=;
 b=iP9dtNZEgKyTN+EQSKMos/gcVxumS7iGaFdR3F2hwfFiLo1e6N0mfokolpdH8KSSgHT1
 d3D245ViGURxAJsEUeyjijhh6RXpMgyQiMKDVXptYtnYG8SrGN1hAoxSIBmOl0NA6Ey2U
 Ul/ps7iSIMh/CTraMVWnSckt1DllLbixBU4u/jAT/XSFgFygU1fyWeSCxmyOV4OHI4Bv+
 cOPocPW2rjbWOPyBix2TDjcQkbj+HIQZx0vjyH9jduwIH+fXEKOT/juKxnlemZ536AEmR
 Twungm+wwcEJYegD9Hc50yr3L3tud+jxAGHv1AZZAEQcL+YmxPu9b8BqJ9o0NCSQMvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=k4WDySiB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=k4WDySiB
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C3D98110B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 01:30:23 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 46e09a7af769-7f4e2118db8so147458a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 18:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788485422; x=1789090222;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zxt1p7Le9HZ0zieAHawbQivBc0+yCY3yAKUadNKeE3E=;
 b=k4WDySiBjUL6ASDpZHnEHIR9ldvhjN6vUlqc3phCF5rrOWhOzeEVlAEc40Xe3Ni+9F
 h47xymfygjfx2oDMVU/YkTpMJGBSLLhce9Hr6HczUJj0MW5J0ob6Vao2aEMSzzui2TQQ
 H6G/1jdEBqAoG4115pAWSb6XZMftCCze5ZzJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788485422; x=1789090222;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zxt1p7Le9HZ0zieAHawbQivBc0+yCY3yAKUadNKeE3E=;
 b=dlQGynWfueDdJkJ8CnuKPECb+2f/Ce/wuZa/gyu6xl4SRyDPDMZu/b/dQsMJYryMMP
 RFts3F7/5x9rwne1OILncQ83AzzZYq+uv4ofeTkvM3MeTKoceJ1MUQEF+/ddfSlmGFTW
 jWy4Os0ip8LIhs1Qs8oxKxKH4o/HuzdH/N3LoQ1ZSk+g/IDNAgGEg+4E6yFp6B9ngd0r
 mFnvxuo106MfM+KofZT2CCwWO7QLAx3VNAUpcoNTbUrz9wB4QHKIcX3ZdHhPMaVHpOk1
 AcnRmowkDPWM5676V4U9hqQOaCiT9Py0nLISqIfkjo55JM31m1oHVcFVMXt4awR50JSE
 JYVQ==
X-Gm-Message-State: AFuF++kym6A9o/iUZbwurZerCHSh2rag8Fz2WLxcqit2xty3DlQTNeoi
 7ayzE0AUMhD4nBnUeBNgPnAUIO8f+V/pQGRlFuurlKO5+rihVlllkd3xla3M6SH7E7PMIrdc3YG
 tvKC+172WqsB9TWM=
X-Gm-Gg: AYBFou1MtNs+UCmcU5qOJ2iGRnSX5HJYfAY/V0ELuxH0yRBzeqjkbzl9cO+Lmo3qM2+
 TUoPDsomATPTP0qwuSUps2bEqJ0ILocXIn9TppMbLFJ7888vFYWV61qq6a4RbwMoY0kA8NRvuyQ
 K0vTpYQl794iZhLuYSx2qNee1PmX/v3ETL14CIPCu9735eHhrgWpPGqW1GdhODUvoXSlCSfeeOm
 6YvifJ60fiU3KN5GkhFZferNUHEeWLf4Zc+V6i66ppoMZdyH+BEPVOCwu5N5OMlLFwqeqZ2qgFR
 G4GTNipATd5NgbEfKBwhKY6MxcJs2Bidy+5WZv4ikHLCVuFOjer6gonuAwbjVYAnw2+RbxFrzvn
 vvmpyCPVzpDKi7O4POKGH5oaxlXyUINHbXvnaySOcRXaleJWLTMftSz1O1oqdcm9GdIFzF8zI0i
 uWlzYoP5x1RLyqApAA2u3FTNXVlm24flvjRX6XQ+IkvSBPxF33cbrjoU4Qjw5TQoLrxjnY2qU+p
 pqi+VhFHF+1Jl+/CUHoHAFM+rb0xF643Jhu2GjHk6EXQbTCWsLLwGJ9W8C7QwrXP2KgHdCupoZ+
 q5DWw6EvM3Dg2No5SihO0746AlPviQ02
X-Received: by 2002:a05:6830:25cd:b0:7f4:d59a:1c62 with SMTP id
 46e09a7af769-7fa1fc64ea9mr2563755a34.11.1788485422502; 
 Thu, 03 Sep 2026 18:30:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f9f7aeac18sm1607634a34.25.2026.09.03.18.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 18:30:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260824195224.556419-2-trini@konsulko.com>
References: <20260824195224.556419-2-trini@konsulko.com>
Subject: Re: [PATCH v2 0/5] Fix logic of OF_OMIT_DTB and remove useless dts
 files
Message-Id: <178848542189.2694560.13579223979050016922.b4-ty@konsulko.com>
Date: Thu, 03 Sep 2026 19:30:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 24 Aug 2026 13:48:44 -0600, Tom Rini wrote:

> Hey all,
> 
> This series depends on the series to correct the logic around
> BLOBLIST_PASSAGE_MANDATORY and found at
> https://lore.kernel.org/r/20260824194814.555634-1-trini@konsulko.com/
> 
> In this series we correct how we handle OF_OMIT_DTB so that we can in
> turn not have an empty or fake dts file in the tree, when we are
> building for the case where we would be omitting building the final part
> of the dtb for use anyhow. With the changes in the previous series, we
> can then correct the Kconfig logic around OF_OMIT_DTB and
> DEFAULT_DEVICE_TREE so that when we're omitting the device tree binary
> we don't try and build one anyhow. Finally, we can remove all of the
> empty / fake device tree sources we have, or in some cases have but
> never used.
> 
> [...]

Applied to u-boot/next, thanks!

[1/5] dts: Correct behavior of OF_OMIT_DTB
      commit: b9cd57c5cefab330ec91e9c5143470c2811ef87a
[2/5] dts: Make DEFAULT_DEVICE_TREE depend on !OF_OMIT_DTB
      commit: ad14691f3e5029ff09ffccfa76f9893f5f2a6a30
[3/5] dts: Correct entry for OF_OMIT_DTB
      commit: 68e65953400f1d4fc594f20e834fd2f78b100562
[4/5] powerpc: drop qemu-ppce500 dts
      commit: 9012579179f78f82b3fdaff5c9029be97739fcf2
[5/5] arm: Drop unused dts files
      commit: 99df7f47155100ff0fc83f5671ab5064a72d3e5d
-- 
Tom


