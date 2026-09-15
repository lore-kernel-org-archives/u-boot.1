Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7561C88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 621B980C06;
	Tue, 15 Sep 2026 20:35:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuTvvSARHHqI; Tue, 15 Sep 2026 20:35:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B461A80B5F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504534;
	b=HOEcbraGyjMcJoS2unOUFIy+xeX/03ao6Y7KAoCJ9halfW88Bmcfpt/7pDAg/fZB+sxU
	 PGMO8rmsTDxJkUS+dugOvSpAv9Vf/77stUa3IMi7qekVSylrJMwhmvQs5Gfbgb2uqfi7U
	 Oeb6RKhG9FLacLdtQ82yzUWStsO8YouBwimcrP0LflnT4jYP/oYrxCu0e5g7ZklIyST6l
	 7Il0SC9q7ITbhA1MGGIb75iYxg+wc1vXr/4Q0deD+uizCHVUCDCksba1WW87+oS9l/BD4
	 XoP80Ve3PD1MD7L2+EhPn4Fs0l2QfXeuK8nmDhdUwl6UuadltXZsEWANgw2pPaq1pxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SL0NL6OIBHQiQvGmjB8nuIv8M3MbewlVpgynZjLaxQQ=;
	b=UvKEdVlyTE/eUnBFu+zALPXWi44K2EEMql22pNJDVYjg3uOaa3SQu/0A1jApcuEmCoxn
	 82XhYVhTalj79sU8GKc9f/JgurztCPD/xLeWFIx6kmHvyfeEj+YMKL+L5Fi52oyUiug00
	 Klu0xmWpzR4klQe0KbehVS2HtWEE60HrN9ITZMcB59o0rFrE0iMRkcDm8VgeB7Fri1VfO
	 uQoBXgHXZSa5oLf1bzB3NherXlmyMNoQE7k4HLL8cU3jub8+aH0h7A8CWkg9vpwhY+En2
	 nMuBrGzhaBqa8z9GjHVW3Gt1+T2VFpVS4PfA9oyv5KNoKHNUn1JhkiPwYAYR4cphPKg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504534;
	bh=SL0NL6OIBHQiQvGmjB8nuIv8M3MbewlVpgynZjLaxQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ltIZ2S66TUP1uqFFYAZXKJPbc1O8FSTC/MZWkbXnVnO0yCAI4JsH7G14mQ2B2v3X3
	 fLp1IkQgC1hGfO4WER5qnlwqxdcE+Gg1Riq8U1a1ZS2tE5ozB8KbKDT0/sn/VWIX8m
	 U/QIkLvXE0iHezR/SDs3Uwqo1UoB3U3qorIay3TXNMFbDxhpxAbE8YxnGoZjAMNnz/
	 H4XfyUcvXeE+xKTBjUUVMtfu/hO1PjUZ5ZB/gpVcNPBDTSJFWusw37QG52GvhWGIzk
	 TkezGHoGT5KdkGva+bvhUnqtJ7KVmCDcn2L9C2jni79FHzbCq/07Z+et9BOg2Z5V9k
	 4rHmxoEi+4pBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B461A80B5F;
	Tue, 15 Sep 2026 20:35:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7DD53352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6400B6061B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uSZjyTA0TRQU for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2E386060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504526;
 b=X9L41M8JGDGwwsrUXNOjytgAnYcJs9y3RWSweGwO53i4qTnj79M6fI+Wt6ksRE8JP/N6
 FBqyQaNL8cs1AV+TLuEEc52TZK82l2my8sxBWYOM5IwqBwj7lIUrOqTife7D4Hg4v4HyM
 rk5FMfqc/7jr+nT6BMp+yp3ehVjMoHfPcQlPOcwZc1MSQ921XK4DUZkGc39DBr7b+uHtX
 PWTxqW2RvlCcLh2QQfujSsElaAUtKJXuyOUSWrxa6w/u67tWuQWLTw6Momag4b1PfLWud
 tWvbS2v7Wmjj1oZlesaqGWjU8PL4jYcPTvqO+1u6rqDK1eYtHWHUmehhHwDkS2dMDug==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504526;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=SL0NL6OIBHQiQvGmjB8nuIv8M3MbewlVpgynZjLaxQQ=;
 b=kJJGe72NI/3/C9tGPZ2XwGP+BxBrbduWu97toEjzDacIxSMsR6d9aI652gOoFR4g1LcM
 x0iRTQewZ8bzuZZLLFbSKwFQuovChfsjwCubjQn1T44hEmQlFbx2vgPtqauR3luD1SBDU
 aThY4jLzvgQHRyxKWVOw48tdDxmx+S9uUTtaAeOk7GyLJaSKlV/ZAtOlmp6JXHoflqesv
 Nw2Nz+UlKi7RQS8+rkszFVivaODz7993thGw/YXvIz8+qLzO/8I1Vn131Tug1Q/u1X9L/
 hUNNrwcL1u6OuRkCNs416CZibSCVwl2Hmz5m+IZ7pJ9JiomIsIooHPSK+5NwQKgXwNw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=klzrTTTs; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=klzrTTTs
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C2E386060D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:25 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a3ed715so210688b6e.3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504524; x=1790109324;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SL0NL6OIBHQiQvGmjB8nuIv8M3MbewlVpgynZjLaxQQ=;
 b=klzrTTTsUL8JrMN1XKkG5DYnzS5gipfZ3kdrMYCwGGBhdOPxahfvnCc40hjqh6jK2K
 ldA4ev4eixTz+DZtTpExmINDNV/MBQhP72T+TP88sy3RxbppKn/us+QMeITJ8SmsqSnI
 Z1T8PKKDxIwzXmrxPiNixpVXGGnBqpU5aQ+7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504524; x=1790109324;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SL0NL6OIBHQiQvGmjB8nuIv8M3MbewlVpgynZjLaxQQ=;
 b=cyjxDEOw73/pFcKJV1voo/+1ylB0eCxWk6UPriZAaRO7ZdpXhwdoPJmc31VzSHPv8O
 BEKs4owfXZdAwaexHgTEoWOd1G0kpDZNd0r1/4e8wIY1NuNjQ7z4B1ANV1jzzTcyphxB
 nPo8YFG7+yUfhyw7joGCD01/NQ6K6Fjh0r6SxkL6Ca0MLbgNkWOrl3BQ9j6YtS5kcCLD
 6K6BYUnuMlSFrErj12bRhEg/OVeW25lVkag4uFEStDQVFE385HiMIdXACsqQzVckkkwK
 Y93zIH02g4rXlFCLFGmNnyTN9s9VMBaBKKpzd4jfIw4DxhfNiRbPB40iCOWjBcVptJUL
 Aagw==
X-Gm-Message-State: AFuF++l95PtfW4lLc6uoEjY+o3iYkzTj5Ot/V4bC6SIsaUX3sOVOBhxZ
 mHZnkPrj6rNoIIDnGsBJLu5Sa+y+rDFAjX1MeoKICb1B61jnZFdJ5F0/cA1nLfQTn7A=
X-Gm-Gg: AYBFou0RgwP6AKh3e8bcCyfQwADT9ZiwANgIyh+JraZy0YrSLXipxE+rQ5X8qpoPtgl
 LGs+yDPp+kDy+trmQRhJxHouOfkM7HyktI6ZloUKwm2Bi2jEMwPiRvE96SSBILVgXt91yUsekZd
 8dR9z3vS/Pv47PwECwzG/le/D/uRUyOTV2fWoFo0wDw+7GJJrtBNXYR7hai6g29rsequjZWxvYC
 Cit/MY0j2z3PWzX3de+NvSFITrowWS+vrFVNx+j2movXbmgRLZve6hNPbROrGy7Q2rD4L2eAJRz
 nhngHjwbi6KRLClWu7Xooc5uYLP8dmxsfvGevpOmsqBbOPunEDHycV6X4bJUQZPO2bRk3pQ1RIK
 /NSXGRWTT6B+/ehe7DTHULIh6CE17ugG6Fu7ClWq1vdnsC2YFHvZxxs/roOz8zpztbA5SoiNFMl
 4nxjy1HLJBThLdXZFSHIppEMhq8JGAMJ9WLi0Ubav7XklRiyeTLNyl3Ua/wwHfrxjTInNRPA5Rb
 yBaMAk5aCkc4+uhu3+Dsa9p84uU48qgk4RzdJn8/1Uu60A9DwIs/FptxBLxOsLDnuMhggqm2p+x
 nLtzxzsJKkk3dlNZ9bk=
X-Received: by 2002:a05:6808:4f4a:b0:4b9:a829:f013 with SMTP id
 5614622812f47-4ca4c297594mr38579b6e.31.1789504524295; 
 Tue, 15 Sep 2026 13:35:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
References: <mkv6dosnzm64fr7y57lhsynqhtiy5bhp2gawlk7vstfyjm37cm@tntjqgtdok7m>
Subject: Re: [PATCH] board_f: fix use of uninitialized variable in initf_upl()
Message-Id: <178950452306.931545.13249199206541412788.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:23 -0600
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

On Tue, 01 Sep 2026 15:50:35 +0530, Naveen Kumar Chaudhary wrote:

> If the malloc() for the UPL handoff structure failed, ret was checked
> while still uninitialized, leading to undefined behavior: either a bogus
> error code was returned or, if ret happened to be zero, gd_set_upl() was
> called with a NULL pointer. Bail out with -ENOMEM on allocation failure
> and only read ret after upl_read_handoff() has set it.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board_f: fix use of uninitialized variable in initf_upl()
      commit: be8f96dbaa5e7443911ac7bd87dfd83e20af0623
-- 
Tom


