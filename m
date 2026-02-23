Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8328EEC1112
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A27183DEB;
	Mon, 23 Feb 2026 18:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BtM632sj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92B0883C39; Mon, 23 Feb 2026 15:42:48 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBE383935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 15:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c6e266a3572so1462759a12.0
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771857764; x=1772462564; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CiCaOozMaBqtu0W7JkoLLdfxEnVK89AmMhGax1pTnn8=;
 b=BtM632sjObzbgi4ISeXXv4NroRc/syzFWCPiown/C3KmXXv6HRMP6NKsuLtmVuA8gj
 LMJita4CPY/7otIpEBThwulyEQ/y0cOp2IHiyVawUnZ17lRQZbn+bhuVpMIcx8YL5ixm
 ctUdierybGf0B9rjRhCafJyVqFkuVpnjc4sOg/YkgVL19aMseujr3l7EaCodfP8IQcsb
 pDdsjAGckqGjkUoDkACNeCO/LqeE7AuBh9HamWZf/9IAYIVHheRrv3ekyIIZOmnsb2Fd
 ZyKzvF2YM87oD8kzz+Qjc8huIMipTmu91ybNrbX78Rp/T2I0v/kFZbur85kLhvMBROgZ
 GouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771857764; x=1772462564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CiCaOozMaBqtu0W7JkoLLdfxEnVK89AmMhGax1pTnn8=;
 b=Qgd8ENnNKSfhN9lHBOruIQzoe3npgcsmrkmZ4lTvDmnnI3y8FYw6VKdf1iBvCz/3BD
 W1I7FygqBCVmxsEGifK+eRGZPB0oy907SGyKe3MfHwfmUewAfhjjM8eQ05gASoPXnBLv
 X2qOSh1ZKPV+xzHLhSTDd6ycEBsVlamMdQDqeCTGJPHcjhjon/mwBiNTom2b5OhLzTCW
 L/5SQ6NM+cO8et0pznWnhBnNW9P0faSgmO8NfZZBEiKZqO4oLkarL1gxi8cqbkQqFqBZ
 oIRssptQiIBfE4yPj41ycAqFdmSrCZVWjk4FKiTHIOu6J+DJRA/01XbpQLOWuKZN6xGG
 0IXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZND0Lj9y/uhm0jejyumVtwAr8PkdHFsSLbCp+dwk7b+3WyuUCX3TTdYkEnNGyYfnp/Q/2x3U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7nSSlp0SScTpFwuJatzzhLwUVzCGFP0QMlr4zMVHF9Wdh1Ad8
 sCKgfh7f9RRBKKecaJMuG7kaJakpAQ6e9+8e+sEbZzD3NJs6wAF8FK1D
X-Gm-Gg: ATEYQzw8MHJc/9Qjgd3jeJyOm1ds31Ic0wnnyWkkF0NgaEYeQdK5/gaCtt6ox6CVdVW
 hO+PZ3l17qrahsHgv7sPW+VFLAQXOGot5kaU9DW8IdRm4oXJKl2jnCpOmlTHStVLr9eLSJxkLtZ
 zGit0nybRiYPdnGEbrGKS++Q07gikr2i3DEqtLoBLcwC4Fi0gV9wZKKaQY+nD9l3/GT75TvXv7z
 b9iO+Px7G2IxKiM9Y9isVHVvIuR6cFrcZDXORLDV6wWbV2h2HsymXqqv0OW0ULzdBRYiA88HlQ+
 blcjI3wadUn+2xEOtDRbDki5+dIIP17V2CfrJWjpdgddi98D1yfqY5tK08bqy8lplkghiflp2C5
 wQeKUoxC/zGbDIjYPqgO2SLYy2RhwQ93gXTP567w9QjWPlfVRg9ORxak+przyAGjgpiU/GyENqk
 ZKZVDF47gs+6Rc/KuiN0HPX+lFFOYwf1NZ5kMnR6VrUxcsVq6M6qlWUGH9e5KDTTPHZ/xSNqDz9
 jQjGiYUxkR6nyA6JkBGuw==
X-Received: by 2002:a17:902:e80c:b0:2a1:388d:8ef3 with SMTP id
 d9443c01a7336-2ad7444e7fcmr88379735ad.18.1771857764461; 
 Mon, 23 Feb 2026 06:42:44 -0800 (PST)
Received: from [192.168.0.2] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f5dae6sm82875165ad.21.2026.02.23.06.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Feb 2026 06:42:44 -0800 (PST)
Message-ID: <ae45130b-9c94-4a9c-8cd6-d7fd4a996e20@gmail.com>
Date: Mon, 23 Feb 2026 22:42:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] dt-bindings: net: airoha,en8811h: deprecate
 pnswap-rx and pnswap-tx
To: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: jerome.forissier@arm.com, marek.vasut+renesas@mailbox.org,
 ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de
References: <20260221163114.87553-1-lucienzx159@gmail.com>
 <20260221163114.87553-4-lucienzx159@gmail.com>
 <20260221164556.GZ3233182@bill-the-cat>
 <8e1c4274-797e-4f2d-b1ff-c6ef67bffacd@gmail.com>
 <20260222164950.GB3233182@bill-the-cat> <aZvfnT8C-g3DXBgp@sumit-xelite>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <aZvfnT8C-g3DXBgp@sumit-xelite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 23 Feb 2026 18:29:27 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom and Sumit

Thanks for the feedback.

I'll wait for the v7.0-rc1-dts release before submitting v2.

Thanks

Sumit Garg 於 2026/2/23 下午 01:03 寫道:
> On Sun, Feb 22, 2026 at 10:49:50AM -0600, Tom Rini wrote:
>> On Mon, Feb 23, 2026 at 12:27:02AM +0800, Lucien.Jheng wrote:
>>> Hi Tom
>>>
>>> Tom Rini 於 2026/2/22 上午 12:45 寫道:
>>>> On Sun, Feb 22, 2026 at 12:31:13AM +0800, Lucien.Jheng wrote:
>>>>
>>>>> Deprecate the proprietary airoha,pnswap-rx and airoha,pnswap-tx boolean
>>>>> properties in favour of the standard rx-polarity and tx-polarity
>>>>> properties defined in phy-common-props.yaml.
>>>>>
>>>>> Update the example to use rx-polarity with the PHY_POL_INVERT constant.
>>>>>
>>>>> Link: https://git.kernel.org/linus/44f62aa1b1209232cedcfb39097fc1bfbe75bbc7
>>>>> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
>>>> And for clarity, my comment about cherry-pick also applies here. The
>>>> script tools/update-subtree.sh makes doing the cherry-picks
>>>> straighforward.
>>> Thank you for your comment.
>>>
>>> I checked devicetree-rebasing.git and it only has the v6.19-dts tag.
>>>
>>> I will try to manually cherry-pick all phy-common DTS-related commits from
>>> Linux.
>> Outside of extra-ordinary circumstances, we just wait for them to be in
>> the rebasing tree and do a proper cherry-pick.
> Exactly, directly patching DTS git subtree shouldn't be allowed. I
> would rather say it's better to use alternatives like *-u-boot.dtsi etc.
>
> However, in this case v7.0-rc1-dts tag should be available soon as over
> the weekend kernel has been tagged with rc1 release. So just wait for a
> few days for that to be available.
>
> -Sumit
>
>> These changes look fine
>> (but waiting for other comments still) for v2026.07, so there's time to
>> wait, really. Thanks!
>>
>> -- 
>> Tom
