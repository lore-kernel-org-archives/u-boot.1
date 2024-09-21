Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DD0CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD57188AFF;
	Sat, 21 Sep 2024 16:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927521;
	bh=0yRhi9xGNLGPX4V2MMhCT0a369mBVtxfTy7fMsl8MpI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LdR/YykGJNbIq/VKUBAd64MOWjr9OEEZmp9F3XxQK60v8WKInvhgmQ4auZvg2IXR6
	 c9ciSmgb5SwB52dMANvBZRKG5nvbkrFxBwFWFBSLjwSoBk7WLdqdRtH+e4wUeZfHBH
	 jwX4madRGKeHN23lrIAz1X451fSSGWjgISnzl+/u0WEMTSUKVz8Ef3+WBhwCosJmY3
	 Y0XZK+EE4yRtdilJB2xuIsm67o0cRDZuCydL4mp06BIUrcHBrZz/xXqdDX5w1krf6/
	 QL5kH8VC0s503izRij+Fzi9b+IZMoUDUta/jCPd/MooDYdgbj9uwMnDzAHkdI4RzGB
	 SfIgOT6qFu+EA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 08EBD88A3D;
 Sat, 21 Sep 2024 16:05:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927519;
 bh=0yRhi9xGNLGPX4V2MMhCT0a369mBVtxfTy7fMsl8MpI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ze8SgY900lhQlT6cqYhTPcKlvehftiQAVK3a0DmyfD2EBaMwCcKmJnJxuhRL++MrK
 CanEvIfBnmJWEKT4Ney3T1u1etCnfoAOmxe7nIwwIEsxblEYXgneecNx+0TUabFSJT
 mHSnY6ahBQknQvjlLE83tnGUHaPCPnjs0Yl+b+VP6XKs12vvJwEesH4twT20X1ZrpC
 euI4W8CLuy60p0HnmFjUy1moDBb3uGzldlKwN5/Kd3PZUkXdARGdTQDQ05WeEDPJNm
 MO2ZXmYAoDwxqtI2gsvD9UrdXaukNpv7CeAhW2FAPTXMfCLFSo3O9KS9YpdzbQjgSs
 BovTcDhLlPsLA==
Message-ID: <858854ad-bebb-4199-bd8f-a5807a2144dd@denx.de>
Date: Sat, 21 Sep 2024 15:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/20] linker: Add SPL linker script for SoC64 devices
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-4-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-4-tien.fong.chee@intel.com>
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Add a new .data section for preserving the original state of the
> .data section of SoC64 SPL. This new .data section is required to
> make SPL reentrant after warm reset.
Where is the linker script copied from ? What is the original file name 
and path ?
