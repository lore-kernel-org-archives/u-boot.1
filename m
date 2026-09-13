Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B65C88E56
	for <u-boot@archiver.kernel.org>; Sun, 13 Sep 2026 12:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 758E46060C;
	Sun, 13 Sep 2026 12:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44g4iTF3Y2nC; Sun, 13 Sep 2026 12:20:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A81F0605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789302005;
	b=XNjV9o3/WVmA44TfMF/dqCH/cdMuD2obrXP6nHn/6l1pv61u7sscAps35uI00z0Alcuk
	 lAxXH7m2hytCqEpHHL3eXL+1zlWLZxFwhwElKo4sbW8xgXw+nlHdmflCDcGqTEjIDUz8P
	 qSuMaf3pzoneaF0W5IV5Q4WSSLn1Pyyit9+uU4yodvHp8yxJRKDlcPer9F2rrFzBBkuTR
	 bb/OqqWg+dJIOndOVQIt0wghJ1Ajw4TTPIIRpPRqtG5uHY9MFWL7M6bqMx2z3gjv5lhJz
	 vADxgAjb5q6ECGYIRaR3INCBkJsbrnMjdSo1ZvLJ63qknZV+gxK5iNBKz5pvGJmTICw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789302005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fVDHmoXuEtpGUTcn6RvTHcGrPuI0sxhsvn4q8VezWBo=;
	b=TflCPFySkdy68jojVPhXClqe4a1wivyqFe0tsqS3BjXP2PAVqabHMRTIKGAUCTYP/A+w
	 cbe9V3dJ3hLpI+xg5VQrAOj65rAx8hOednODa0wglxePmGDU46aKTPPA8LaYyuEYCeZiG
	 s6cr0YVP4JQYlPGKEm6vX85NATYh9umlGuhfC1eu+6aTr1jePE/Fj4Vbhw77QqlOzJq9P
	 OyTazngaOmePvzi8Oh1qb50AzsAvRQwVx8waUmVOFP8vFciySyx5WO6jjP6Nh0MOyXRQ+
	 cumU1QIsTI6juooQZZv0HxBtmnIAgo/0UpwQQlxHSenPLevIuEL6WrFu6UxzXr+v/bg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789302005;
	bh=fVDHmoXuEtpGUTcn6RvTHcGrPuI0sxhsvn4q8VezWBo=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IJFzsuDWaNO6hpvZc8dSA2/nP/Aw3iqnCwmy4YhAh9omGuERcnMCf5VJMN+iBdzrB
	 UKPJDUMP/HIYL0BGl6+wOHZheq6NppSJySbSwvA5gW/s3H4p8vhVJR/apLXIp1ckax
	 4WVHPo/jWKa1K3I8Cqn20NqcyNelIhB4ZAdlp2AkMg5fhCNxQlKij28eDJH3oYpnwF
	 Ed5KL0cNR2fuyIANvKqnxOkDz/Sa3DYq6+PeFBoLKpAHHVpcYJNWxqre8/1mR/zoeT
	 cEPyzd+yKV6Se91N12pMT7msVNrxAMpcPCvJuKDHwX37/97RX06fc+rEZCv4lGS8u4
	 kk42g00yBICqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A81F0605FA;
	Sun, 13 Sep 2026 12:20:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 872E12D0
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 12:20:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EA5440084
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 12:20:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j28J0j2K8GuI for <u-boot@lists.u-boot-project.org>;
 Sun, 13 Sep 2026 12:20:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 42DFF40022
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789302003;
 b=sFfDMYqagZzTNk0v3yjKXQLYgbNsuetghPKsSxBdlXsmv88rQyVUDXfE1fkMIW+qDoaN
 AtEw83Olce6Q7BVE2hm9tmybkJgcCD5m4DPb1zYHl9SKCeRUUJZ/4/xEvYoVBSdWksJjD
 ISB1svtIFdNypDQ4qKqAZpKB4Lag+3ae1+OkdVsQtg4Uy12jrtzTGj25xGALEr3T009gA
 NPCAt2K2gorMukCljkmmt4Puh+9DSLnSwibPghnHQgqlTBU5ARmStEuvQhWFYYKfMB+B+
 2wgHIQlmq2PLOXS42rXRGwPP7FFxbkxaBwCel0VjNwbrjiiMheWMOojiZ5JKygouzSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789302003;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=fVDHmoXuEtpGUTcn6RvTHcGrPuI0sxhsvn4q8VezWBo=;
 b=OvzV980DhoSAZK36iokl+lQJPayaaItEtTeoxadAw2IY4hU/gRP5TqoAQZcHgp8xAC+O
 seI4vNSfPf232wPjR4J8pUuuuz9aZbCWiOxPi+ULOnGNIsmvEaq9ZtmMcOXNAt5vEDC9W
 gu1L+cQXPmckyOeEk12lsEo87Yix5X2khk33rDXVBswmn6ob6GAnBzSuPIKzmIEv7n4kt
 ezoScT75RLBJUUnqsPbM6mSGpv/j1H6Cx9P7Ot8FijZoHs/TiWWaKxcyDFw2ktqEJGMQV
 CHDHUREzVQ1FFpAWgRAxl+qU6Axyc7Tp1YEMCTRiJ8mI/bfcZit0m6dluuX6m+Zgk+A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=crLlS0m2; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=crLlS0m2
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42DFF40022
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 12:20:02 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485b1d2874aso960894f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 13 Sep 2026 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789302001; x=1789906801;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fVDHmoXuEtpGUTcn6RvTHcGrPuI0sxhsvn4q8VezWBo=;
 b=crLlS0m2CcOPFHoqzeZ8p56+X6CSLAHrL7w1595Uo0qsiFVsATS/nIge3Tjz+TDLsj
 ch+lMF+YBe7vPzbIYceVuyTF/SDelJ5Mq6qpJ9m56Hv67AsIhx0BfpBwcQp48QtbdnYb
 5+Nf1iWtxSkJ8y7gMhodbTCoZKbrSLmTGaEXI4OprH4EZ8TJ3m27HzTEujB8ZrD60dvB
 nb3LyeWB6mYgqlfQ5FwS0CXe73vquR5UzyqLBvhRCEFZ+ICjKyacC79W8YiizuxkA8DZ
 Bk4HduKZhqU8FFBCVxw+jPf7aT+fF/A55rSWlmeAPSJgut1HesFX8dgnsxOnUmyyA0iu
 +z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789302001; x=1789906801;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fVDHmoXuEtpGUTcn6RvTHcGrPuI0sxhsvn4q8VezWBo=;
 b=MJ9pEPlYpdFKEhwk8Yx6Z0ZEc2X70VINd+ycQKgreKn75P3N6RuuQnWH2kcr3p1vxn
 6NjeWH6uL75wopdKrx6Ap5Io6K1wwTE28ig293rkbJbVIiqJnkfgDrvZ2Mn37t8GFdn4
 K4PCnL84tH876PEFX3+sLVJDIqk1C+3EYrszSIfHSjzeKS6Hq/fqbpzkjSG6Ot3dDH3s
 2eolB6Ypg750dB/QKoZ5o17QZBtWi+K/Ca/tIJ0OPryXGD3WBFL4ZECN26yhJbcD/CbV
 q/mWVgopejZcbkVesAQY3W6vonxl+yI9yCvstHLkF74y0kCXuGgSTuT8MrhrwPc0uNaK
 pwQA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzijV5Ryxw5RPDUmRwacBQZ7SBPAFUSBDdudPpf76jDK7SrN2sFHRCeWIGEHCHb6QNNoMddAhg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lmgn6eKHP8eFGqMUPjLgZZPXP3ePJMMQWAnxQYREgz1f4VdJ5H
 dCJaVnNVYrX0SeGpV4m8BXgzUgJqiWc9oK6mcG47yvEJZOmWfsRgdRZZXxEBbQFi74g=
X-Gm-Gg: AYBFou3BaulBBOSQQZxkCEX6jXbBlxGVmXsx3Psd88Kn43co9ZsBqnd/sglMOn5EJwL
 ToIunNzLLGwfbeaQvqTpVbYoB0tJQ3k6yS1RHGVtBt3KUR+ioCgsvUojH9ixfSmC5xk0exFBtzs
 z+/plu10pcxuV3WckavZvAYgowNe2dY9AEFO+79iiq3Czik9Rfbl2EsgfluXeVuGQzXJW9lOC35
 /yXoIPUzreUWTqyCLfE4KyEC0VduLcDWIc7ZUVzlJh9tHvbMTBCkPMWacHbTejbWEG5d0lLOPzn
 iuO8Qz9MOZJNGRlDnGxK4Dp1caWMwGc1qdhyPYdaillWdFyyPSMnI3eUOACsBm6RhEpY+z5xag6
 C5G2FbePS2kxa/rE4DN4thKOdYB9HkYVPf1k7vFVilt25ZsfPfDu+ZBUc4dQhMUIcz05y+zXRah
 z1bcRFPFa4y9XVGttL9TVgk+uWv0aiVKvtod9yzMY7zR5Uzw8CZ0LpsqbMHiNUAC5x6YJCYL5EO
 DfjBCy7pg7ARHlLT/9cN8uKBMFK24i88Z1um0YzByR9bp+40A2hSP8mJNQtqYc=
X-Received: by 2002:a5d:5d05:0:b0:486:e5f7:89c5 with SMTP id
 ffacd0b85a97d-486eb1d85b8mr28342606f8f.1.1789302000528; 
 Sun, 13 Sep 2026 05:20:00 -0700 (PDT)
Received: from ?IPV6:2001:41b8:9c0:900:f8e1:5877:8eac:95d0?
 ([2001:41b8:9c0:900:f8e1:5877:8eac:95d0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33e020sm20007348f8f.18.2026.09.13.05.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 05:19:59 -0700 (PDT)
Message-ID: <f90eb8f1-f2cc-49bd-b4c0-008359623b75@linaro.org>
Date: Sun, 13 Sep 2026 14:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "configs: qcs615/qcs9100: Enable watchdog
 autostart"
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 quic_varada@quicinc.com, balaji.selvanathan@oss.qualcomm.com,
 dlechner@baylibre.com, u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
References: <20260911093210.1351573-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260911093210.1351573-1-aswin.murugan@oss.qualcomm.com>
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
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 9/11/26 11:32, Aswin Murugan wrote:
> This reverts commit a50e32bae6abc8d86d4fa6fff9a1c8f5c88baa4f.
> 
> The watchdog is not required during normal U-Boot operation on
> these platforms and can be enabled by users if needed.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   configs/qcom_qcs615_defconfig  | 2 --
>   configs/qcom_qcs9100_defconfig | 2 --
>   2 files changed, 4 deletions(-)
> 
> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index e060fac3726..27666a8129d 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -22,5 +22,3 @@ CONFIG_REMAKE_ELF=y
>   CONFIG_TEXT_BASE=0x9fc00000
>   
>   CONFIG_FASTBOOT_BUF_ADDR=0xa1600000
> -
> -CONFIG_WATCHDOG_AUTOSTART=y
> diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
> index efd6c63f212..082106157bb 100644
> --- a/configs/qcom_qcs9100_defconfig
> +++ b/configs/qcom_qcs9100_defconfig
> @@ -14,5 +14,3 @@ CONFIG_ENV_IS_IN_SCSI=y
>   CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
>   # CONFIG_ENV_IS_DEFAULT is not set
>   # CONFIG_ENV_IS_NOWHERE is not set
> -
> -CONFIG_WATCHDOG_AUTOSTART=y

