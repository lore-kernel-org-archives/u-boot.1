Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5599C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68857406A8;
	Tue, 15 Sep 2026 20:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFOyOi-iyRss; Tue, 15 Sep 2026 20:35:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B6F344066D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504542;
	b=IDXKXdjo40D+SSIPzQUMLT/yLquWEc/gcM5NMOZ1krIZ7DQLm03O2cXZhFYnyaB5xmB1
	 IL97yfAtBLbyRehkTJjOJw10OAPSfA205AcGnJrzd/1Rg0Y+W4df9M4mJI7j6wH3Gq6XB
	 PRFn8/CEW1UpHel73+Ru7i+lL3GRO5FHbo3RllsYdVa6UDYHoHwFs8EWNFNNqc6vcs7oF
	 Dtl1Sn9zFi8CbWz3NsgM79QPyRRZXhSYsdKnlWbrMmxMkruSCC9bEH+/NLBrNZ+S+aXDB
	 5DeYzfj21vhoYk7CPV69FFAwrllQ7vOO6at9BXjSyd85ETN+GLuqmgUGAWhYssI5WVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tNnwJqwyZiST9wDiV8LU7V2n7a1RxjuSIKCqe22UqVQ=;
	b=UCcre+Ea+H42IggqccS+PLM4ctYo8F9xZp6JlQ1w3xJJsMh061yjoJDUC2VOTg+Ltuq1
	 //6AkbWNXRvQy3qKkQdq175DjzFLfnyPrWth4i/dRAHwZnAuepXSThWM0djniBz8nBYhL
	 IYc3FLgyd7CG0ys3rgH4Ux3kdHQOunIs0/jG7fSIeaPhD7MiTAqyYrLuxn7ROX9aocOIC
	 fpKnOCdml6nfOxhw7dwYsYwHzXizdFcmx1UtaNHt+ficVf98nb7NxjoUmjVXvzoI4Nxsu
	 GUKb6DYfWSP1T95Sa4PxVvFYuu6ZeJ4tgHgfAZ7M8BUBiqFoHfsVazyvDhbzIWSi1Jg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=VvwxCV3A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504542;
	bh=tNnwJqwyZiST9wDiV8LU7V2n7a1RxjuSIKCqe22UqVQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rxpFSddMxrjSAvkr+tya9JeIZN6AV03CS4NAmmDIKFXSYSa+88vk5p9JBjv03xUgs
	 FjppZ21ozN/S5lmTqXNs/Q3KSWCyFflfNpVnyyWzl8s+XTaKrZXJ01NIvBtu1YCUvW
	 6z7T8roxToZn9HdqFJjs6BmYEqfJVQRET53nYg+22pXPZw84fpY0gSCS8+r+os1v3t
	 cKm7A9GQe8A2hybN7c+ddidExyLIuVrMYTPZzpBF+puyvqnt/+EP6qHhfrNMLvlcm7
	 gT5ueA6IRBut28/CgS6nQBD773/fSZ+9JVtnF6yQmvEXVuV83lWQagFVlLhzcJjOud
	 t1NRVRQSB9xnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6F344066D;
	Tue, 15 Sep 2026 20:35:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A6E67DD6
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 96A6F406C6
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83DCpFR1q3LL for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EAA7C406B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504530;
 b=hsRLh3qhmW8KegY1T30YwjqpxVRQFDGFNvm/wlWnSaQ+YDg2/gx/9N5WsiQ4gEsKk6/n
 i67iNCvF8+D88ZYnmcuqkDq6QAllxXOcMRwhS2T9KUm2amdeukpaWub3si5kpBCw4sbjl
 9XwxB0r5stxAqCsUqk8JLWvSdQBj1G/00/S4lWy1GaNGr6cTQrdOaSx2UjkxwjMcgdqyr
 Tk77AmsL7qbdU0sZpAxv2Aq5zrrIZHKGTPtN9KSC3O2gNBWXRRIqsHQn6b4lk/SWJpH1G
 l5c9FNUZNrc8WHzMFbOTnVN7v/RMjfapsBL6xvpsrbAR2/Hox3MYXQciefM3nQvBBlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504530;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=tNnwJqwyZiST9wDiV8LU7V2n7a1RxjuSIKCqe22UqVQ=;
 b=PaPumlK9tY/jJNjKB0NQhRi/UOQI3hoYHnimfqtlMn/IolWb1Hvk0Q1dE4EL0MUiWFn+
 lMjRGVtThU1H83NBAysQ6B0jwS8ZRDdEp7MztWbfMu6aMCS/mzqchyFC58zLCoeQETPVZ
 H0FoAAPnk5D15OYvGbjvYm61JP3JNxnbmV4JRprSCm2kXlj4JdP+lbQtxnlpyBcuv9ptT
 xfPDSn5sVu6g2uvbj/osyG1lpG9UsHKSTiJkOJI43o8yovEuAc3dL2UVztd8eYOvF2AKK
 TiiKI4qsyRKyIO5vvH2HTrYbvCm/FnvYKcCJfTxDlBcBO/zLTvbTMnn7gUB6FJTHvvQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VvwxCV3A; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=VvwxCV3A
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAA7C406B9
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:29 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4c54eed93e4so114289b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504528; x=1790109328;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tNnwJqwyZiST9wDiV8LU7V2n7a1RxjuSIKCqe22UqVQ=;
 b=VvwxCV3A/q4/7JYm5d0OKm4nimsr7BT1fkTwZtPnEz+kzPHkg9Ss/R/PVCKYPvPbCA
 Cm86wwaSw7VtCzL9ILgjzdaDJZaBoE57RHpiOzBduB+3XZHcIubJAL90ng/9hvFK+8xU
 SAzqE5sGbS4phacqkaJgiLs5QQ3si7y5eeRKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504528; x=1790109328;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tNnwJqwyZiST9wDiV8LU7V2n7a1RxjuSIKCqe22UqVQ=;
 b=RAE4XR3561TgRdff21bwOQ9knM9VnBNMXXKLO0/OPkdDIjgvhbrcEBX67ofifA6JXV
 9w2wLtLh20YwPKHW51KZHR4H5CXnWb2VTKECWv4XE8bqt6lAb5wnGr0NBwchi1iG7Rz8
 /mZVytQu6a+EJAt+CZVNMtOcxmGGsdbtOeQqeGygEVGLS7non0TXpUcllvze/O38lqJ4
 sfGB3WBDxOYUReF9UiEHKh667mI9ITGSiBHXBvO67CmRiSOAFmHKUAQT4RS/yANN7FCH
 FsyYLwAmzH+3Pte3B/wYukNrQEtCzYaziRynkDQVhY6o9xeiRf283KSL69BRovWduu9j
 JD1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByVJ/I4LiKSmCkMEKQwh+cYsPsIXHlBjs+4V5t23aLMXI8Rjem1siSfOI3cIjxHrU40/U2dLx4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n39SG/I43zkMoyLNx/7BDJ7TDh2kMVlYFBHOtoJrxEOrrOBgE/
 5Nwsr9oHv+UPy637TEDgQoFsEf2QHPOZB2HepoM9lidxF9gjn+86ORvWyD1DmKYD7P4soUrrcxg
 rbfkeh9yhkpWt
X-Gm-Gg: AYBFou3y6iRwC3amj3LmJcKbjcpz51mfIQRMIrB4w9l5FzTe19Xz3C+5PnJIczc/56N
 zwAf99x65k+M0nAsmBRYnFVdOOO62EtG9Z3jInLg18U3CkAXDwec+YSD9c7LgKQtZuKMYWiH6aw
 /8LvaZ0woKf61JkwoBeMgwO9HgJlFQyqM2w6cELW9lADOLT0JCw3GtNQNhHWAVxafcWds6yBjl5
 m6bGQZAyaEQeywATZjBHOfCgMYZXX9pKYCEYB7ODBOTLqJtdv15S25D5Ypq0ojDsKOPvJJW8sc0
 IkSdgnPDRFHxVohh62A1QhOhI1ss5Q/mYVguEY1mCb+boryQHi++4AVShR336FbHpNiJB5KqUlT
 pEwWXj/m79v1ebMxQPGq/PT7viCkLllIk+WOLGSiO/Y48yLmtM0ripAw8cT4yhKoiMvMelRbT3F
 CroE1jiP3CstglcwGWt/FP6zE1RaVdiD4Isry/Is0Z74hixAnZVC0wtSSg/FBAJ3f/LAy7J7Mgr
 qfoZf9sou01QOnca2QBe+KC7n6LvEp911rPxsu34Dh+MSshdGml31kFXz4WlraP/ZP/8FyubxNK
 Crct/EqULTbtZMV5o4c=
X-Received: by 2002:a05:6808:1706:b0:4c1:2512:ee84 with SMTP id
 5614622812f47-4ca4be66e81mr40054b6e.23.1789504528641; 
 Tue, 15 Sep 2026 13:35:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <20260901-typo-v1-1-89ea773a9a05@arm.com>
References: <20260901-typo-v1-1-89ea773a9a05@arm.com>
Subject: Re: [PATCH] spl: rename DISABLE_ALL_EXECPTIONS
Message-Id: <178950452760.931545.2900926416498852770.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:27 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 01 Sep 2026 18:20:44 +0200, Vincent Stehlé wrote:

> The DISABLE_ALL_EXECPTIONS define has a typo; fix all occurrences using the
> following command:
> 
>   find '(' -type d -name .git -prune ')' -o -type f -print |\
>     xargs sed -i 's/DISABLE_ALL_EXECPTIONS/DISABLE_ALL_EXCEPTIONS/g'
> 
> This can be verified by pre-processing, for example with the following
> commands:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] spl: rename DISABLE_ALL_EXECPTIONS
      commit: a12ef680c0f19662090f2e28ed8e2a89bb17d947
-- 
Tom


