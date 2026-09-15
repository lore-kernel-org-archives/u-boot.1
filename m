Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2BCC88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EBA080BB8;
	Tue, 15 Sep 2026 20:35:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UmTVDHjQwspu; Tue, 15 Sep 2026 20:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BE2A480AFE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504528;
	b=iZ/UQNCdp+bM62wUKj9GFyd2OEFYKTn6ZmJrpyTTfXbiyctCcWaWh6eQmUIDiwhoYf8F
	 srCaJGKysFQiKjlJIiPm+DcQGhDVUgdXbFycwkZ0CqZCgpbFCGp3gwHVM93pW91y7u29V
	 rB9BnZzn0HDDtr8yjFpwi+QM+vUcwlMZamVHpUKtDDnmBz5bIyXhVukBijwZ9HYecFAeo
	 sJzUbiKmWuD3vcGKDvU3UuxACl+Mmr1HU8YQbVK+ZcFjX+eh1ooNU6kMTJ0JfTND4qQmU
	 2iITcHWn2LSyLF9L/g9290cS3gz7smGQtiAL4j6zuTl54o/NcxzbSOMECxQqVxh3CsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504528;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=domAjzzPuM72prvuqzYFN+Bou7boOkIy4soWpOc1PLA=;
	b=lrcZvXUWKzzZ+a5nDvMUEmCh0JolGod02TJz+km0uQMfu1dmgP7qmNcGGiB0a+1vu6DC
	 pW5pvsTX6Pnn3h55qiUR6KnVjY5RySjojZSv/MuUcqW0HMPppgTJ5P7/Kfbw9p1z6snmi
	 nsqbqJ72Wcp4k1bA0+SgsQ4l+u4jR9qbZDtR8wZEov493B4FwxdDDyc3XXP7wsHfUQWfn
	 Jd4D/J2G0U+Y6id9U4J++ZCY/mW3PtTRFX9u0ht5NkZgR5ihauqvTPi6vUGmj0b/MIOVR
	 LSlYO8UIZipKEDxLkv+AwenCVHAH6EBfNN4j8nSOYdr2P/iMYyM/2ShqEAl2JI5h3Yw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=aUkyUVhz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504528;
	bh=domAjzzPuM72prvuqzYFN+Bou7boOkIy4soWpOc1PLA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xp4rXF0VnxRFdg6uUnAqQr854HHUYFl5gvQK7p/YSJqOTW8WtFmmCQ9woU4RrgfFn
	 YTqKzSqPZGk6ysLjHjXcUPz9hkwhmNILsezPFmxtFQffQJsv4XymbLnZu6r2eZzAYS
	 bOvVC0d9rSeonI9Fj6oHqGcTavq98cOVDgh5f95gA/frvMMShDRYekzdc/GPjFLbDL
	 uwj03pyriHyeYBUPJqS/p5OlSNsbMOhF17Pu7OFtTlNgFYpTXPOWW2rDuiZdttceZB
	 4F1PAxH1w6BlKMSYp0Qo4SOSpjCuOAwnPVfhiYeoNZi5tsQw9sO1Qz1vqekHyk+nvm
	 AtDcB9aij3jPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE2A480AFE;
	Tue, 15 Sep 2026 20:35:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F179C2E3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D186580969
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8KHB1x_t96Al for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 33E9480AAD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504523;
 b=R9mwUpHQe+ReNOvFH9U5zKiiRK4ka9dMz7V09jDqiMaw/CQkznPgkG52MoxU36+3EpIc
 CEIDv/OLRy0Mbvk6YVh76vq3oykKyJqieNNemr0zVi0gTCwIVXlesKP3I70QPkUXPc+Ox
 nEFosxo6CxHRWfVtehoeS4LdHEhJi6h9GjJMhOrAzoJyvkF3lhOvooGZMYB68ZujrWcOB
 rvGfAdWxspPOFRingYxM1AbRA2VoRfWbsJ7idx7L5M0Fnc20+vw17V3AQeDsKPfPfoL+L
 ToCXau9wdnyPGTWoHPP0hP84XCZinuuT8K3eym0qKqjUnUiqBxaHQ1D6dDVfQzr7Zew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504523;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=domAjzzPuM72prvuqzYFN+Bou7boOkIy4soWpOc1PLA=;
 b=QKfM8Kvbba0lt6i7DtTYjY+Lz37i3Krz7Aa+qDbgQ06zcYxSIBWjGNE82G9Z1fmZm9SN
 jBCH5kU4RI53K48nhACrNfFYcc4tI7oD5inCu5p07U/hKjsLZRnCGgaza5h+y7gkLHXZ3
 pIUqz+5fua50nOok2SjvVAaCy6PJJnG6RjpNAOjoVHjH8uv+gYa2UfmwD32j286A+VT0f
 r9ilHcTASGqWRkvjhu2HGtzeJ/hr7snfhz6yKWX64gdDKHldfqesBOOLNtaRogepT91Cp
 iX19VFHDWdg/NNGBb2gzhn0rj0LnDh/BilxSQFS5D8lDX85qwf9iuml365OvcqkMeJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=aUkyUVhz; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::11; helo=mail-oi2-x11.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=aUkyUVhz
Received: from mail-oi2-x11.google.com (mail-oi2-x11.google.com
 [IPv6:2607:f8b0:4864:32::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33E9480AAD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:21 +0000 (UTC)
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c206dc8b0dso213569b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504521; x=1790109321;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=domAjzzPuM72prvuqzYFN+Bou7boOkIy4soWpOc1PLA=;
 b=aUkyUVhzFpDWQJeA0kkxMd9fmZgCUxFFA2MdXPo47mzKeWJQ14pmlvss5ojT1+GZYW
 aef+O+mD91/4tiZOQ71DXIsfYvcEOA9ZMfcFE+Oh+8RwAmvosF2IT5FEnkH7lnEtRh2J
 xUe3yTtPAr8uxvQBq3K4tnc0d7qA9HmEzcJ2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504521; x=1790109321;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=domAjzzPuM72prvuqzYFN+Bou7boOkIy4soWpOc1PLA=;
 b=QPaJnUpnDujNksDjtn7f4IHVRbSLMpJw6lAUSHFstzDYqtH1bz1l709w5zPLI3ilAV
 QRXPCxcfa63sMWhf0S0byLw7ZyKRLZFe4VCiJap7bsqg/YOE+Xq2DyZxAqv4pJNquOuI
 rGhBZ30h23nJqKFZKJ/kI2dTXsz7YDHWrZaA/9G6rO7lMQ5i/AOvCrLbJsjop6LW91YF
 2de1/dbIsaXd2djQos2p6EhuhAaoBNvMkCVfad6RuH+Z4XspVlxAJMjWT2Oir9BasUoz
 xUMs+6sYBQxi+mOYOdH8Nz24qlLY9WcOQ+9h/XAoqD57TBde5KpuO5THdlz7CaBkjtyw
 j2Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4tnQz4CbJutx7ZV7Nwfavk7i1TqReLA/b7ulWiqO+54Ou8upOEdmt+oxeSXT1XBeOYQCjxiU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l2K12KQPi8YmmnDou50GE06STSjCqUzcXNx32aVtNQFKwpTblU
 VDTkPvM8ablaMzAXAXEb52eHupFP3dJ10KuOpTwxY5/UdwPfx2j44RRvYznxBDUKByY=
X-Gm-Gg: AYBFou1UUOjj4+tShdPallV0GxIEAHC60ka7NK1XJynAgONL92X3z6gOUigNqNZKSf/
 nxEMJcyKVzDce3IO3LMWA6uktlFxGoLtXP6AQ0xYQAw+UMrJMdmmgkouwrjFhNvr3u3znmO5MmB
 WnOA0MSL8jpIA4C1Qoi1elsvWNx0ufspJyyaWldAQUptF1MuhBThU60ocVcu71nvVzl17BYIkgi
 0cWwJkMXzCEC7Sy25lXMLpLply2lfapgYuyGYp52K/5asftKHkvrOCtWGV/daEc7+BxT5YwaEXj
 wkqYBjCjZYkuYmk2om81hpB/R/9strXcc48FdOX9/7RC/5bphXZRA9+Yv7kGo+DEOT/TUp4iynN
 q9gyLY+cF7m3f7ZS9JtB/y5dcUbsqJT2j8jOvPwDUozzcJwEpu1NYzq0m2LJvxXvE/+jrQEKJrw
 L4icctIXPfBDU7uFrHF6oCXTFxnk0x9Q3Y8/+ehxNf3CBHcKjVDif1NEWuE9xikMgnc8U6UH3aa
 baOvxjwCEXL3n6QM0CLQlN6cbRqLMUcUQS/WxlKk17QIvrhoGhUjIl/pprsNh4Spsk8WyK8jfuy
 8nwhaLIgzciIOyF9jYzr
X-Received: by 2002:a05:6808:c2ac:b0:4b9:e65b:8c2c with SMTP id
 5614622812f47-4ca4c285f7amr41303b6e.26.1789504520717; 
 Tue, 15 Sep 2026 13:35:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Graeme Harker <graeme.harker@gmail.com>
In-Reply-To: <20260829-ide-strlcpy-fix-v1-1-05676b02d822@gmail.com>
References: <20260829-ide-strlcpy-fix-v1-1-05676b02d822@gmail.com>
Subject: Re: [PATCH] ide: Fix truncation of device strings by one character
Message-Id: <178950452002.931545.12754828400274969881.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:20 -0600
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

On Sat, 29 Aug 2026 16:53:07 +0100, Graeme Harker wrote:

> strlcpy() takes the full destination buffer size, including room for the
> NUL terminator, and copies at most size - 1 characters. The vendor,
> product and revision fields of struct blk_desc are declared
> char[BLK_*_SIZE + 1], so passing BLK_*_SIZE drops the last character of a
> maximum-length string.
> 
> This dates from the conversion of these copies from strncpy() to
> strlcpy(), which kept the size argument unchanged even though the two
> functions interpret it differently. The original was correct:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] ide: Fix truncation of device strings by one character
      commit: 0b4c421190a69dbd2b5d7b0990865c07c6fcb420
-- 
Tom


