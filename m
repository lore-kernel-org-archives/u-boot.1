Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE08CD37BB
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 13:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C6C8662F;
	Sat, 16 Sep 2023 15:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LNpmhdUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1920E8650A; Sat, 16 Sep 2023 07:22:15 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 020DE864C4
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 07:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.linux@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68fc292de9dso2086178b3a.0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 22:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694841731; x=1695446531; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:subject:to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pxTtJxpEugnY5DiLi8bmm1rP95Jz/heVBLdqQhUAP8w=;
 b=LNpmhdUpceqlcRUbemcmx/NfvAqY5J8/9/i/DVS0x/+0PFKba+1nVQHI8mMGOaRHIn
 BgJUyBwh5RFdnb7z34YFC/trk4NgSt04DhZrzCdq2s+wjnQEQpwuKTLN4Nl88yNKjhf9
 FD7nDEahtqDwLPvwSTBr43dn85Oo4MciNIxNWbWc8NX4lnyofQbdIZCPhYIFVsj062cC
 f8X6JmS3X04H9aFSWQyDGKqZw9NA3AZjJ5q5xPq9lgeWMGvVDFmYJWp27Ykb1ZTyNaRS
 y+/yQ8GCBSVbWjIKMlfYVZcG7BZ9+vUqmARcqE+p4vpVgTri73/EZTcxvxUWAJ6wy7Cw
 kojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694841731; x=1695446531;
 h=content-transfer-encoding:in-reply-to:references:subject:to:from
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pxTtJxpEugnY5DiLi8bmm1rP95Jz/heVBLdqQhUAP8w=;
 b=DdfMZGCJAMd6RLCCt7BW4rkTBMeZDO8/UDpWrW14FOZuXPVUX55mDj+kZ86UTeI7NP
 zqbalS5v1zWWuir407DI/UZwceilP+71MQHq/tUzen6BnSPz+xi5mgxgF8QAkbt5nCM/
 qGMO+j6dm9gFK29LhO8tPlCmMid7fKJ2dX+5J4mrl/xk3t03AjUkA4ZboAixUnchUH/5
 q7Ipsr4XPcXEPlq52WkOmPSeUOLLiJGHpJGuoJxjCUlChEwAGVk1kBjj+i0OeMphzB3m
 VpjohKGxoV72SQ/xbgHpsMMS8H+14wJlf5N/1auB13P54B9zGZLcURvxz+GRcl60/NJq
 ezmQ==
X-Gm-Message-State: AOJu0YxWrhvW/L/vPwyp+KK9ImmIyeX+OpCE0dTkrNmHsjUWUfC9scqb
 yhBiTXUu7vkdQo+aec8YzaQ=
X-Google-Smtp-Source: AGHT+IFaACgGIlKaVHWSk9OT7WwnGGuCAKG5X92GUmPJ4dXK+v0AlEYDg2aOuL9TbxLgpykfV9sGFA==
X-Received: by 2002:a05:6a00:198e:b0:68e:351b:15b9 with SMTP id
 d14-20020a056a00198e00b0068e351b15b9mr4504542pfl.4.1694841731136; 
 Fri, 15 Sep 2023 22:22:11 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:c4b6:ed28:95c7:9a77:34ba?
 ([2401:4900:1c60:c4b6:ed28:95c7:9a77:34ba])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a62b40d000000b0067f2f7eccdcsm3738806pfn.193.2023.09.15.22.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 22:22:10 -0700 (PDT)
Message-ID: <c8474d6e-1e92-bbde-3bd3-52183947a7ce@gmail.com>
Date: Sat, 16 Sep 2023 10:52:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From: bhupesh.linux@gmail.com
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, sjg@chromium.org,
 trini@konsulko.com, n-francis@ti.com
Subject: Re: [PATCH] MAINTAINERS: ufs: Change Bhupesh's email address
References: <20230915181442.3403172-1-bhupesh.linux@gmail.com>
 <4c9658ca-1cf8-e985-8ced-28061a449ca2@denx.de>
In-Reply-To: <4c9658ca-1cf8-e985-8ced-28061a449ca2@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 16 Sep 2023 15:31:28 +0200
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



On 9/16/23 2:36 AM, Marek Vasut <marex@denx.de> wrote:
> On 9/15/23 20:14, Bhupesh Sharma wrote:
> > Set my current personal email in the MAINTAINERS file.
> 
> Why this change so soon ? Did linaro raise any concerns about the 
> maintainership ?

No, I am going to pursue things out of Linaro now, but still related to Qcom upstream.

Thanks
