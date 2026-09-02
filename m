Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA67C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 22:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 509A56081D;
	Wed,  2 Sep 2026 22:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1Y82hPEAAL6; Wed,  2 Sep 2026 22:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 796906070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788388244;
	b=Ry2hfAmuoLQCI8A7g/F0a0JUoaPABVBgeMh+lQMQiG7ASPPelng6WVrstcyyte1fA2uv
	 xd4cwA11NxVLsyzpzFg1Utc2oyo4W03WflZkFiMSIQUoqbKguSl1Xuge30yp81uPwcRiL
	 B+nKe3SNreD2MO0L7u0i6IYlJFca8sUgxa3Lg8f8gjnZ9bMhiqy/BLoNKqciY/blEqK2P
	 pkeedJMQwyLgiprJup8XuXRfgrBJw/C/1ok9vkQoJD1dUsa2HvXLUSexhtVAYaHKoslUp
	 ny/Guh5pEM7JyGvkrGb+HuS45yD4lfNKja3plNwL41cGK3dtQRhpf42Q9pcyJCKrEBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788388244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=pUAo0/lxlXmJ+nPEtvyhapMbAIj7U6NDlciZSsnvwzw=;
	b=kuBiwYSGBanHPuMTtiOY3k4r/T3LvLD2dcAvXKBIePjgr7NwO0t49wq69JTEAdmhz5x7
	 97Dzm0TZO7JUY8IfU7AYl7E1oRCwBrXcUUsWDSw08gSzBbUCXTuYNqQ4aFh2JalJr6oAY
	 EoMP+cIsV4WvRVXYop+aX8a7drn0EB08XYWEBXmp4E5XOr2bmPI1GjoCaxiG34MMpRV9F
	 qcemaTHvV9Rzw1WD9ftREfZFWKKvq6qm7d1twwfF62TeYX8stbBs3dBV5EccPP307Mm57
	 5iTKhOo28iVO15wuZ4/VQTIeYef3B48XvTLGwoIWXGIzBZruLTDswX5x/UymplY0htQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788388244;
	bh=pUAo0/lxlXmJ+nPEtvyhapMbAIj7U6NDlciZSsnvwzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zEcuRVmza5n4wC1HkLYK0xTk6HRx/J06+y7baGYh1QvUvhJlFwfAPLOnozZlzwg5E
	 UiKyzncigQXlLFNModjvGeUX0+6PaVnIfCRIO/WbX0lu2Aek7PTNWwVhB3vvFOBG1P
	 QHlHEe/R7Hm9k9/FKbOgG7GfRWdlSwF6IlwNs0kYTsGoAHK7xNM5KWcHIkS09YvllR
	 wM4kMbeB/e2eLRqD7H9p0XVtTtCJ4SExh5MBG7BTx8X5J9ygmjWHSKD7whSlKUcDo3
	 Am8C5lAPDixT7XLbi30/myhzjM9L4bEcSmfSdp9jibh0CP0TioLdZ+XsaDyISlWWqx
	 z3YFXTP4m3fOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 796906070F;
	Wed,  2 Sep 2026 22:30:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51D931D9
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 22:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43D2280FA2
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 22:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ejQafHk3oQ1e for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 22:30:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6883C80F9F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788388241;
 b=KqAgWbmIWDgLy/EirxdGONeq/5iq2obS+lFPTddaPs3u6ONmk+bCxm26tbkMDdKmK8Zu
 zR6ei+yO4MlixZTNTL4j8bng6gMYMdsRcsnoQ8mItdsJzcIM+SZRgYqMMwAV+JDuBxt3q
 srCYZXMTY5K51BQPxNHbGnmB6rEDh4MB8OZIGcHzOklqooOO7/vKvlqrL3h2JMPrZaBiK
 IO9XwvVmopot2wngvF0S/s/JZtF0xXnkk67BA8HJFkohqg8OPcltjFC0+5hq1IdQ8cHmI
 xZJvcx78uvzsex4ewRrV54MAuGW1WbSLuY54IaSa7hX2XyAW6Xy8zeVBzvkvp9+3rag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788388241;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=pUAo0/lxlXmJ+nPEtvyhapMbAIj7U6NDlciZSsnvwzw=;
 b=L93MLzzpngOVRUUg6ttLcunwP+GbdTiMgTIymTWpz1oiFw1hVEL2Ty5OcBiwBxAjYNqN
 Vi0zQV+uwSCCFcucbV8yiFTDsj9QEZhvFMICmwvD5IDFRQO8y0YdiaVSJrcWlTCMwcqTs
 FFb3y6pKsf0LUnzgCf54v5+vkBUd26rc3Obyye/9titTbfWAM7IBNctMh5AQ5FNzngkFU
 mAOsbDw53mjH4UxKSy8WF3aVO/tfKL/JFcDuGgfNGa/L8BRustuBGvSdkJh16SXQ7svro
 D+ksI6F5FycBZya5N+hip6X2jxC+VWg7LCqY+F0Uzg57mMR+2FYaNNnWiLRCTMMk5bg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=G721CVOF; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=G721CVOF
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6883C80F9F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 22:30:39 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-4af7193adb7so392784b6e.0
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788388239; x=1788993039;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pUAo0/lxlXmJ+nPEtvyhapMbAIj7U6NDlciZSsnvwzw=;
 b=G721CVOFF8ouFL6eMxOMA4ys9kUGpbiq8925/15jQmeuVf4voi54/w/xAhcUOuapQW
 Fuqi4ZOLf4nbrTUrqFALxLKJhMwHnsZ4h8pEB65BHagja1u8ceiPXFeVlvfM3Efe3+vd
 DmRL7uRWfuOKt3jiol0VSQLRfqwFmAytqF5DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788388239; x=1788993039;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pUAo0/lxlXmJ+nPEtvyhapMbAIj7U6NDlciZSsnvwzw=;
 b=BPxZIPHdrc2CBiX9BIagKo8jvpkOlyh/rfL8MwW0TRZivXRc5lif662c0PpPyoo4CY
 uIkAdNDYHpT1K4YGNvLc9yoE9JI+c7pL0NUchG8CcF9xYsFIplL6L6/FL04eIsluvta+
 5Ul1u9Jqf1MASXH4+Vz5TmM6mm/m2ehYmimNzJLscXgm9jCem+XfRdJ6bowdsA19zoYL
 q/1lRkAQ81ybk1ngmSoD0bbD4/CzjF+zuvrrvoH2KdV7thtycDZvmwYRiWGOVS1jtFeY
 y9ERZx1IQpDr6JX7OxHfycy0SY/voEXSHomtqDAgU9NdZr+VATdLAfwByiKzeQWlfvIs
 JZrg==
X-Gm-Message-State: AFuF++nsBFlwva7mHAASgFbu2nEVDgEGRqkDzapIAK4FzgvU7K43RpYI
 2QVI7FgKGajAZactQM2LwPvAZwNVrCCPbGMjW+hbyXp2eZkPkSt8DI6XIzL1nxlqZEY=
X-Gm-Gg: AR+sD11GX5KIL9Ond9yoZRd55VkbokVOFa5PVoTeJUtfh1U1LAFivpXChBll+rOpCcK
 4AzAxso6+27vkPtVE5rYMAJQ5v0ROl1a6iaTiuPuCx2/WphsuQauY4Jn44Cok6GRSWw+aECYATE
 xJN0j35/T4j2MhZ20m21Rage84pmikgjYuhYtnP/kc/KWJgixk9dHNGknZuOMZ9Utu7+6l3pZsj
 D01UARHx0tysXH6TwOFSYGwptaYokf3IOQDAM9d+i4Mg9wC0j+f+mCWQVu2pobZmKQwOjgVuAmi
 iChUZ6VmBqj/oskFj9j1u4Rtr5YA0k/H3SaLb6k9dCmXFP/T2XU4z4FIg0pnns+oYu4ByBYHN1K
 qKK0zMG4PeC/OofHNat90cAsAwxdDOlRdcEl+UNQSRGGn1shCZudmU29hMiSNDN59U+2u1004Fw
 Lx49ztxxNsukD2i0QpYKMOiwGoDoobLODrcyQYrdRyfaF7TAmgfzSR3Ezkm8v4ID45xxWTBg7Mx
 vk/vaTGmWY/v7NEQ5W+P9q3KrLuiOZN/aRFa8p0p3miDgYBREcBsOBEqISJ9G8L2nszoOMD2tPv
 M23B6Ebk
X-Received: by 2002:a05:6808:50a9:b0:490:315d:e0d5 with SMTP id
 5614622812f47-4b6bee73ae3mr8560184b6e.16.1788388238861; 
 Wed, 02 Sep 2026 15:30:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b698a32578sm3246212b6e.6.2026.09.02.15.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 15:30:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, GSS_MTK_Uboot_upstream@mediatek.com, 
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20260902184600.3717230-1-dlechner@baylibre.com>
References: <20260902184600.3717230-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-next-2026-09-02 into next
Message-Id: <178838823808.2025409.3508335126974939667.b4-ty@konsulko.com>
Date: Wed, 02 Sep 2026 16:30:38 -0600
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

On Wed, 2 Sep 2026 13:45:11 -0500, David Lechner wrote:

> The following changes since commit 4a4bcb0ada8d43390e2819e62f4baee723631f5d:
> 
>   Merge tag 'u-boot-stm32-20260901' of https://git.u-boot-project.org/u-boot/custodians/u-boot-stm into next (2026-09-01 08:11:37 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git tags/mediatek-for-next-2026-09-02
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


