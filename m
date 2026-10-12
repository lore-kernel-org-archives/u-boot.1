Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD96CA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 21:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C82DE60711;
	Mon, 12 Oct 2026 21:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gfy0rO-hPwFq; Mon, 12 Oct 2026 21:30:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29F7A60680
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791840639;
	b=Sfo7khOHyiKif/EYszzBt75gtJsYZUNl5jk1+dzmjNsZsecUFd6jheVLFqWkPSvXwrpf
	 NQIK0ixCh7wSM0hJqHHGxkywAykty6i+z7OdkPK9JTTffjAfhVynrsMl3gZrb+uEg3vqF
	 L2MgPm6qEaU9aEDDX52VhhWXBmYDLfrSJjspKfMopjpxyQTxzqg+zs3HQOGwIxowHiyfr
	 iNMKKd5X+mZAx4XRRZyiTo0e0iYI3vlYwbiUFDnzMJ93ZE5nPjstJAiEWPuahxMXy+4HQ
	 DxH+k0mpHyLJ9ZjPn9OwgJUxcT0c9Js8gPZ9+vnVlWcs+XfMrN0anBM+8SvEj6q4LXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791840639;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vn8SaSBTMkveKcFvn5/D5L5/h8Bx/WV4hz0VzHC4JG8=;
	b=SBcf9dJ/oyk48MBT9LDU5FeyoXV892OPD+os8SMdiIIOkYFIKRGk1EhMUckNJF4ZFy4J
	 D6xFEsxMWiRt+iLAso6XZ3zS6tX0t6MDhz4IoblDnR2dkZdWRxboWSo6K7Gm6oEwfmM1a
	 /jHJNZV4xMthBASoTXQRnyHe5OP8SLmTh6TU1Mpddk6IyGo1k8UXmURoQXMA15qukWpmX
	 cm8sqWFUmvAfDoXRfUm9xFnPgyByTZIOeAACqotr04ajtm1praV8zagpiShpPG0uC5cgF
	 XjS+J+iSMhVCDMqQfakcaVxh0Gu4l47bH8EqTmEJjuOjANmO9FZcN4EDyrOvEfR8Dmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=BPpBwZQu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791840639;
	bh=vn8SaSBTMkveKcFvn5/D5L5/h8Bx/WV4hz0VzHC4JG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xsJdgMIfrelJDydVnthEQt0BIP7ShYpmbu0do+U2Rf4Vh5tn7nGjcp6topQkkTSyV
	 tZtI8exl+akeGSl7YvI8NSGsh+yJY/yEuM+VM0XaX6j1kB8dts+AKUlC1S13Kx1zP7
	 Zi99v+dbPZCwkCndWWJgr+JGGnM/0KnvQ6A5G9GcADt8VP4f6RidQApPkbYnI8QnUU
	 IPR0ND0VWGP0H3eIwcD4BZvQQJ1VViYAYLyjZOpDKBekLIGIM4b7dr9W35I/nuuLMp
	 8x2avwOX4L+AR6AY632U2/YDwrh3Y4E9kkfyjVnBiti9PedTqEkDuIOuo4KKl29lqZ
	 +4qIETBvrUDqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29F7A60680;
	Mon, 12 Oct 2026 21:30:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 035E32E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E961C60680
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:30:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4FX6N6Nik0rE for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 21:30:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 40EA2605A7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791840636;
 b=s0kJIGcW4FiQ9NGjdj7mx6spktynatEbC0o4Hzx2Yds7gYH9XUXZJD9Aj40lzNNIXMpr
 WsLb9kSWn3ut6A8d8x80YIknNcAGKyUJurPYJeYPD+YEgcWzCVLiCDYjUTrjjEjnA4XDF
 70ffYtQiOPJ0YILLIt9oXAkdGm5IgOuDGkBU+LUlHJ/5KH7nlf4NYUU4ax1DEfHDRljAD
 uMJClSPCKLHKTWDTepWL25RXuCP01X0ms59fjj7XKyW0E6ttAAqbL9MjTjwdqFtdqshG3
 2ryuYSpAkW9jCFql3rAriDIph33UZ0A2HABK3jBZW2lqsl4f6HYj69VUN1xGkfRihmg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791840636;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=vn8SaSBTMkveKcFvn5/D5L5/h8Bx/WV4hz0VzHC4JG8=;
 b=QoGDYw/G/Yn0fQoMoN29Y0LHIU2p2eYjrIPvHank6RZBmKVtUBSRtwU4PerT342akgi0
 WjrO0gx8nb2V8ze9N594r4KwcmosMcokwtin3LFj96EMXTZbcLJZ5Jeit1wfwTArbsWT5
 8r3lw42iqyb1VZ3x/8w0Z2+Xp/49wowfpe0Fk0pg6jp0RIzWYVK5FxrfmoRJrfjl0Pdan
 fjgNh/G0kiMxuODopR08d9rCItiYH+B4qMIYsQey4DgZ3x7qoHX75DM4dxHfsbOTieBw0
 4TJg3yv2VnN2pPcqvHxq4KqXF66SrjzkxidSILwzqiKxKIbT2ehO/SNIc2v+CL3breA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=BPpBwZQu; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=BPpBwZQu
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40EA2605A7
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 21:30:34 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6de3360d905so2022537eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791840633; x=1792445433;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vn8SaSBTMkveKcFvn5/D5L5/h8Bx/WV4hz0VzHC4JG8=;
 b=BPpBwZQu0AeAe3L4nGSVa6yVKGsWWrXGD62teGt4YQRrGf95y3VuGFsUR4e4KJbgF9
 bpZmvBCTBcRKAX0cqqXIHAG73a7XjrQwfAj2t7w0Tmg+EHiqyeUfvTCr7nSi7EVXLyg1
 abYCN2FyC2z2PXiXYbkY9dOEseI6bWkUsEZbPnEujmzD8E+aE2fmTsofsM+9Cu4k35RA
 d0s/rpuxcdfrlIJLciLR21eZxuZ42K5o1FmLNmd719XbRjjptZBAXl0eY8qAXJblleAr
 /uFz2Nueda/tngaRZamp7p6nzTEfbXhy1TVcUS8AH0dGuebv/EvjNkxJURZ+YE4XJCvk
 krwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791840633; x=1792445433;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vn8SaSBTMkveKcFvn5/D5L5/h8Bx/WV4hz0VzHC4JG8=;
 b=nMt43rStVJQaWj7Nk6VV799WxtYDcz/AFbXWWykAO7q9K9P0zg0RnuTf1xUaaJnk9j
 hFbyYLGituFzwCuAY8lFmx29MRqDlXl3o9NZUGBvsIKjJF5iB6M6dCvD/MQeswGlDai+
 HfBU086T4armhj44zEtm+AErjL5omQ6tEAlZtielcrjQKguQahO8QIINlSR5hZ9JnQ/i
 EsRDj92Im5F4YnncA/S3BszTheOB49ai/IBt+C2I2VuEa9moApVHIF3t8PF94+6pZEf6
 P1LMHdlDQ1X7ZemkUrUhzMUX+cA3+LvhaI+VGgN6cdg/IiGkqIswEO0X3aGFKws8O++V
 KD2w==
X-Forwarded-Encrypted: i=1;
 AKwUvByPWab5yI0K+je2nrqcL3PSc/P3qvha34prBgp2znKUgol0wBevSc8LBbRCEIErmPHhaNVgNBc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJXyNjFPJKQRDghp0+lAFzty1tR4y+G2IeJ9UeFdValxl3uMM4z
 oAel3EO0vKCaEcsb9NEKJmZrLLomwplziPHVndHHRH669iOmjv3FxLSQp+zAFYi1ZSk=
X-Gm-Gg: AYBFou0VvUY5q9kmfF/gB+nsgnrWE0HEACRCUAKoyZpBnz3iLA1IPVcOFCdzVzzLZzG
 wcs4BkC3MSa7xheRNvHda1T98XgmcNNqczCDf/p0O1j0wWE/HxNdTlfPN1uPm1dfg1N8HQH3bPn
 v8ocbkY7OxItOQUKNR6515biTaHU4z677Xu12hSSvdGqBZbIpkk25ZJJ/rIgcapn1yt0BKPnvkQ
 +A2S9vCMDph0/wB6YiGabAXxGe8TCoVctDDYfBhcLEGcEZuMOVtDR00I00OT8ZXu9MqoNBls08E
 u5z/KFNaQ7YhLRaT8ETKsCiZB1j+fQRLVrt0vQPfGl39i404PYqx/d50KtyVkwdeL3bpUenCnjy
 NWQEmbn/1S0PJGq7TKUTTow/tXKjEgqBQbr89X+FMr+NplevoaRznZo9haggqT1RYKpcvBWJyTI
 qPhERBc0L+nu9Jz5IQwgxIUzSeY4SHGXa40ZJ29hlKGaJjNcFQ6kCM7siGnCTMUAlU8pJdtJc6Y
 ay75yAR8S+zcch1WU7CogBLVu5ALPb1l1swd/svIv3KNjiP/F++WRfiYwQ=
X-Received: by 2002:a05:6820:4b88:b0:6d4:433c:db8c with SMTP id
 006d021491bc7-6ef0e7de241mr7710063eaf.44.1791840633492; 
 Mon, 12 Oct 2026 14:30:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:926f:d0ec:bfa4:a539?
 ([2600:8803:e7e4:500:926f:d0ec:bfa4:a539])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6f6d6796c54sm2933674eaf.2.2026.10.12.14.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 14:30:32 -0700 (PDT)
Message-ID: <a4786af1-ee83-458d-a260-02a44101d03d@baylibre.com>
Date: Mon, 12 Oct 2026 16:30:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: drop unused fdivs_offs from apmixed trees
To: Lukasz Majewski <lukma@nabladev.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.u-boot-project.org
References: <20261012-clk-mediatek-apmixed-fdivs-offs-v1-1-f366cc5dd0d7@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261012-clk-mediatek-apmixed-fdivs-offs-v1-1-f366cc5dd0d7@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 10/12/26 4:16 PM, David Lechner wrote:
> Remove .fdivs_offs from the fixed PLL clock trees for MT7981, MT7987
> and MT7988. These trees have no .fdivs table, and mtk_clk_id_is_fdiv()
> checks tree->fdivs before looking at the offset, so the value is never
> used.
> 
Oops. Missed MT7986, which was what instigated this in the first place.
v2 incoming already...

