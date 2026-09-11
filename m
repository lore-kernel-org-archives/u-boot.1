Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630FAC88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24E3780F78;
	Fri, 11 Sep 2026 13:59:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGwG0EUBCFNv; Fri, 11 Sep 2026 13:59:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3316B80F6C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789135192;
	b=WTsJ8U9K0q2O+YSuUnZI2vX8/VlMGNxxhTPgFOjlvzh2rEBFTzbOzWUV/aeyuuxlR1FC
	 QLj3GcNQmLub2CqsYs3Lo/ns7FDwlCou0tNCjRgI26JNhd9hS0OeuHZvIOoApEhB1VwST
	 GqNCg1PgGVAPjApoKIalewGsJ4b3EpMoYQtLsW7gBVrPvJOGsXkVKah0TSqli5TAGZqLQ
	 lpcEtSo1lo7NcSp0azCRlmcDXeE5pRMmFBTq+zFpqQobOZrUE1guz48lnUNjxxggHqtMD
	 gAvcESgmiZYWM1z4/2iwifX4LT91OOvm6CVWi0GqD5PVzrWZbeuuz6MPKMr80WT1zdg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789135192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:Content-Language:Autocrypt:Organization:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=QU+Fh+y70BTuQA50WiRh4no0XYEDRV2re+oieNAde3M=;
	b=qu04SDOVL8qWiZCpe+IL8QW0D/wGDJJLg4MDQ2A2xQ4SiRHUOPfEQ0Jt+dwcbzAlgBRD
	 hHrHKcEnnYk3SIHelJFMWyCfsiY7mQe7EZDBhFG8R4MkRqd4BUvLawamz8bRhM7eWCpaa
	 tIDMTcvvbZqV3XOZtLEMGQnWiaurKAEtf+9wFV7IBmVangxQL6RaDJIzy1dufaumhNJSb
	 q4s2KYyRlAvaSVOEXmDm7/CZyPVcyoNsVztEfZuTM7DcrNWhOoKVNDVAZLr1szmwLnLD0
	 e2IDKgfOAXIo8LetgjOyIu7yG2xkQ9kbNouhpe7jL0EPYwcSsCCyEkz2taKx4YvvoKA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789135192;
	bh=QU+Fh+y70BTuQA50WiRh4no0XYEDRV2re+oieNAde3M=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Hnovx+2xAWetFG+pdgfbooF6DAkVs9q/lENnLsoUn2ihXo52Wj2qqPln5vKLfmphZ
	 LgjGsJ0MZ9efmEEzZjh8Mvj485kRT3tr3bdtcJp+wzbnI6MA42Yg7qwxJ6KDNv3zG0
	 Pc+B6yXxfvU1Jvz6Eku2AmthASvfkwPN+4IAs2KMaLLFX1wT7shEo5abIaqnjpghQB
	 +VUTmsmbl81mhZVwnylskUCuO81Yotoj69iYDm3CpkFXIMxr3qoRN5QrMDts6Tl2JL
	 rgeM/I2HAhRK+FLTcKFnPsEUdcTPw9/MsNVXzzg+ZNPutM1km13Jy6H4iUizUgv6G9
	 r+2J4e2da5gIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3316B80F6C;
	Fri, 11 Sep 2026 13:59:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5965214D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3F14060644
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GKqMAC-7_Lc for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:59:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org EE5DA6061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789135189;
 b=mY5gpR15cdeG2ZP51Z/cHrtsDSsmhFj30hMLrkmPdWDw10Qq4stSchrLxW+VNXZ04wg8
 CCfwaxBTOtoEEBXwhYbh9vjNfdnakORcZJNi9MtUmVYsfwTIJdJ+2iDxLzEARb/cJlWI/
 LNlv1w48Ov1ODfs7aWR4R1p8FK97a5nVRcBU0eqYC2wejU3HcSJ7zyb2ghjfVvXTw2FiE
 Xq2HkNAq7sMd/N3i7V3iaRXvxEHKawT8bs5rYRfkQ/MKEVeqNnFJ4mGPdPirPGvBabZxY
 4xD3zDWyI4jRezPhHpsN4rKXql0zatH2dphlxG3Y2wbnSm5HUanPSyogYify/KmFATQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789135189;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:Content-Language:
 Autocrypt:Organization:Content-Type:Content-Transfer-Encoding;
 bh=QU+Fh+y70BTuQA50WiRh4no0XYEDRV2re+oieNAde3M=;
 b=Y4lOYdDCTacBLNRawhXf6BYfg3MGS4+AQ5rJy4aXlK+esZZaTLDPMbie/FDOIiULf2LY
 F/6ISvmhBY+Ju2TVDxhprZXGdWXdBq0vkHX45v5QW7hu+xRbKJWrEgz3E2waMxX0S7srv
 jogKXrwvHKdUowaUWb2nom0NziLSBSYV+GVRCtDeyHo79I1Ej/302Ols1P4QwfJblFGdr
 IODHerkezSCw00n0UUSAZ59AT0K+2ak/GO3mGmCuseQnFS+u3n2RdDO5yYWT0xBMo4R94
 JUkqPIzA1c1y3TmJC8hEcgiluabKusCt+YPAOpSL5o8KjY8wqOV+ocHNznL3+ryv3bw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vZsdfRCg; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vZsdfRCg
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE5DA6061C
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:59:48 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso9867655e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789135186; x=1789739986;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QU+Fh+y70BTuQA50WiRh4no0XYEDRV2re+oieNAde3M=;
 b=vZsdfRCgA5MFadBf0IUpGOh8xe+iigVpRiRYZKaYVZxkvDxEggOjRd5teeBK6kicML
 927kTjOcJhiqV+RS/BnaOfnNTIUatUXzuk5jzwTCfOOISeko0F3RrESGTlrdMfbKpGCe
 3pJGXnaqTemmnKFYQntIvVBPcpnZz3NoJ5Kfp4Ft6LhmlWZtKlAO3R7+Qy1FV78Yp9PH
 C2Os/aky87nH+iqsb+RXXH+QYT1xxNhcZUCPOKMNUarg/ge5hbf6IeE2oizMH7iJSbup
 mkIbFQT2aez8fw5RNTi6lZhYQ8eBqTuE3aib/Oin4BO+ClF5WwLWS7xXF6Adprg/xv8F
 0law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789135186; x=1789739986;
 h=content-transfer-encoding:content-type:organization:autocrypt
 :content-language:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QU+Fh+y70BTuQA50WiRh4no0XYEDRV2re+oieNAde3M=;
 b=dDcpA35VMtVqpEAkuF8u7+Ka8d9wL1oV6BdmJUA09vWP59/iutUrvJIEo9XORBD4lb
 1R9bqCuR90li43AS7VFXas7O/MedrirP7iO/Y7CsYtR6D3Y113H7Be16ysRGXJgqIM3s
 2TXFRrS4IRmZR1DZnqTXBsC6aOaix2BM7qZNPZLsMGYOtD0GejcEErtkfAxRYaBiCY0Y
 ts82pQ/Ir6UkuotIILbD6gMRZACIK1B3Pd4Prf3ejR2x1ChyQPr9L/Nh6Jk8uUAQT98a
 EhHb43SuYns6UKSlCZq6KvmCtMPZuUb428aS6hOvX8KAggN7R+oNbIAYgmWy3Le6hXWB
 YQaA==
X-Gm-Message-State: AFuF++kSM1o0E4eNZl1pga+o/0Jte6DUFqSce/XEOc8+jAT7aW/0rXBU
 K1np9vdYZyI+jshPO86hMF0J4tClIJTEelYbfsDvgbw3G67VUP2rRy5/xRGAk+jAxSCansGbVlM
 ycmj654c=
X-Gm-Gg: AYBFou3BulLqqfDkXFCzdqHHI/J2Eu//FicJXklWV5c7g2zNeMrvyGsrlZdXgOZ9Ftq
 VFP+hSn6L0mVW62qpdWKDa464MXBvbtrMBFAH9t4C3LtJaMHTbWS8a5Wo3MJByj6nN6P0EMYdnY
 DGrp83kfcbZPTO0BPu6GLDf8HQsSnBwPfPNP+YexrgajDgqmpd/vXe7K4O5sF7k18nOSYDlQNC6
 MWRiCgRjX54Y/nP8PiYy+5zOu+Node9Vzkktd2NTwvZAtRSDOBWuiyMTC1vt8iXnINuTw4zW1cy
 g4WniMBCirbYDHKqT8HpukSfSjQzVdMb3zi0AQK9HTMdiAOm8/i6WJYC3Fd/FjMObXJzDZ2F/Ke
 JNb25D0Yl4yZo8+B+BllcDzlwya+bFyKQpjs53jNiNtW/vdk6hHYA+P4yTeJpjpw980nlUz2T8N
 KsKHuoF7KzCmiIGiZW0W+QyBUHF77LHmi0DU7BAAkbnZdjh/gbuPs5FAp6HvlDJrLI4dpXlGyK6
 xyw7ts/LuoqfAPWWQwfiMG+j33pk3UdRTcZE2Gwpas62YPunJ8E87kgP+EdNghh
X-Received: by 2002:a05:600c:6289:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49e61983067mr47091625e9.2.1789135186163; 
 Fri, 11 Sep 2026 06:59:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2a61:5ca8:b7f3:2a11?
 ([2a01:e0a:106d:1080:2a61:5ca8:b7f3:2a11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6aac22bbsm134325e9.0.2026.09.11.06.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2026 06:59:45 -0700 (PDT)
Message-ID: <2c3fa641-08c5-4729-b06f-660a1167ccbb@linaro.org>
Date: Fri, 11 Sep 2026 15:59:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [GIT PULL] Please pull u-boot-pci-fixes-20260911
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

This a set of 2 PCI fixes:
- using proper DM function to iterate over PCI busses
- fix pci_get_devfn with fdt_pci_addr is initialized

Thanks,
Neil

The following changes since commit b4ac71db13a33c4e6532c60a781ddf34b7f4375a:

   Prepare v2026.10-rc4 (2026-09-07 14:08:25 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/neil.armstrong/u-boot-pci.git tags/u-boot-pci-fixes-20260911

for you to fetch changes up to 85a7290d4bc976a57c7ecbcfcc3d6aa67665ffaf:

   dm: pci: fix uninitialized fdt_pci_addr fall-through in pci_get_devfn (2026-09-11 12:05:26 +0200)

----------------------------------------------------------------
- Iterate over busses using uclass_foreach_dev_probe() instead of ad-hoc loop
- fix uninitialized fdt_pci_addr fall-through in pci_get_devfn

----------------------------------------------------------------
Dustin Kirkland (1):
       dm: pci: fix uninitialized fdt_pci_addr fall-through in pci_get_devfn

Marek Vasut via U-Boot (1):
       pci: Iterate over busses using uclass_foreach_dev_probe

  cmd/pci.c           | 8 ++------
  drivers/core/util.c | 8 ++++----
  2 files changed, 6 insertions(+), 10 deletions(-)
