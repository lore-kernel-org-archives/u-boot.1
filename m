Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59182F0182F
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 12:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77372838BB;
	Fri,  6 Mar 2026 13:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lHCDDFyt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA72839A8; Fri,  6 Mar 2026 13:20:45 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316F6836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 13:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.schwierzeck@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso83912865e9.3
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 04:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772799642; x=1773404442; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KyYhBbwPj0kc5IOht8mbDPOAxWpBjLk6+yLmjI51lBs=;
 b=lHCDDFythbLXq+OkzDjmB6cYdmcLnhYsP2HfQS/BhXhP2R52HYFKctqkCVgzJDEua/
 WNvc1/WMZf5JePYW+Q7RRLLBLK/5/IDNxPxvsCwh3JgkQ7CT67P8UPJKIeMnDavS/22u
 KkMmcF74/cJngw+SbWCS8JvUVRmXHuLmB8RxFVX78Tn8672YsuzOrjowmgxXl02WEWXb
 rFqLJ5pdtsIDXn2KwQ5GPGpwFhwLgaevBA0gyT11n/5GA3iHIkEPNQADABYP+NnPl+tc
 FHoSYQtQ4Sl/y7En8UX2e/jV4wUOdU6TQ+6SX3F/55jyvCy8zXuIZXKYYt3LyN7YxFbb
 V42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772799642; x=1773404442;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KyYhBbwPj0kc5IOht8mbDPOAxWpBjLk6+yLmjI51lBs=;
 b=gpMNcNpqUsYloSYIfpR1FZWy1gFjNf4tigXzHOqzMoIg4ySv4D4Gtcy4SHQXcIYHDk
 YyH5baQ8ge/eqUu8vD7ObQ6CLKckRvEhM+ldORu/mTNbQbhLIzpJI5/VQ/BGF4eN9d8K
 1aJ1FEv3WNOrzfKghOClqTvulMbJYz4XTTZhbhPTR+fJq5XXjXF2vgPnjOUsyIT0vl/b
 ZVhIgW/kXb735j7EdzhIxxWXgJ5NeQlrvEgNys+0Pa+bkqmUW0nfDFH45/5iwC12qOom
 aIKkB5Qul0nd1baIyMAWstmYxWEaozkHP9sYxvf5oiygGKUTWs/SzJOH8kt87tZppzXI
 62IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjI4x3ljmP29EZqsAiRVNYHa8ME6XSYXWSQLsJMgmAMWQAiTYydnkd3wCj27wKf8yT9JkZbJg=@lists.denx.de
X-Gm-Message-State: AOJu0YyI6p6zvAgJyEGRXM9j/lm2PFet0rNhXHMdt5zR1xx1Puw2QdB7
 V+z/wTYIyTdkuQ6wFANJTYUVba4qhGsj8y8L6xFxRoegN0Z0mLqOw0gP5bHhGQ==
X-Gm-Gg: ATEYQzwoCyFuVsZeKsC5JjSlAvYXtiI9BnP4izHoud6jTEgKxjPEFW19lzx6dgPXFy2
 HKFlWR/CSQGuvYVX1INEWkYk39f+frHhTQw0YEkSXsYoQiayu1njTtgRgcdCMxX6QNLhzbwmhSb
 nMK8qZ9piMw+DKMLB4bCybQjEFfPrsW85JSQZF5Q7bWQ5KivSXPEoIO8BkWWhLuJJK9sxrVB2xi
 frOiHmykn751CSWI4kHbESngBV/FSlHDz0RNKI5+hZRYsLS6sFIPg6cqx0FgEy71L14K3cuJ+ug
 PbCghMniVWnrB5yKyzKGZ5ivMrjEKnankzpWlJv+oWLJNcFaT6Yxy2Ey5rjOOkY6z1ZKS/Ygbb0
 OdiquPUHx2DXYfxBwRW3MDE2tbOAgU54nnXr2WJUOAWkTf4+dWADE1zv7bIFja0S+AFizaL1zus
 IKqX3Lz6k9gRE0PtpVUfXFB7Kzf1J+ZJHpe64eKpA+II8Z2kAo/XubkUeK4IPc+0mQqr+JBwyln
 0k=
X-Received: by 2002:a05:600c:1991:b0:479:35e7:a0e3 with SMTP id
 5b1f17b1804b1-48526977699mr30102875e9.30.1772799642344; 
 Fri, 06 Mar 2026 04:20:42 -0800 (PST)
Received: from ?IPV6:2001:9e8:9a:2e10:8e6b:a3e7:bb3f:2f93?
 ([2001:9e8:9a:2e10:8e6b:a3e7:bb3f:2f93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fb3668csm195166005e9.13.2026.03.06.04.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 04:20:41 -0800 (PST)
Message-ID: <2a396f16-b03a-4a6f-9594-e0129859c277@gmail.com>
Date: Fri, 6 Mar 2026 13:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/17] mips: Call bootm_final()
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>
References: <20260306023638.2678886-1-sjg@chromium.org>
 <20260306023638.2678886-12-sjg@chromium.org>
From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Content-Language: en-US
In-Reply-To: <20260306023638.2678886-12-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 3/6/26 03:36, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Replace the open-coded bootstage_fdt_add_report() and
> bootstage_report() with a call to bootm_final(). This also adds the
> "Starting kernel" message, board_quiesce_devices() and
> dm_remove_devices_active() which were not previously called on MIPS.
> 
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> 
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Add new patch for MIPS conversion
> 
>   arch/mips/lib/bootm.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 

Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>

-- 
- Daniel

