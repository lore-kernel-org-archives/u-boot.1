Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C299C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 216B581112;
	Fri, 11 Sep 2026 10:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iaL7hgrUN5dk; Fri, 11 Sep 2026 10:08:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4293181114
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789121337;
	b=W3Aj6XojRdPCwG1cHPwG4jZV6oeWolNHK4GkhHyeV81/yURRZ08pAvw4CaI3S3G0goxC
	 wGeii+r9zeT9CWREnm5iJhNfICck+5ZMaY6l+bO4suBFWE/qI3YFq8HJcqjiT+YrrNRH5
	 wo+2QQ61QF6HYkG2bc/o3MzcvWfE0vwrYHgxpHAokR7mS6riKGzoSm3QC58/Q1RFQwGl9
	 dbFbJPGICueEMJCtDEaBA0NM9gIpQibFrqThsk350Anynm2tIjbF8NzYjhlXMvRk4F0e3
	 lbKlX/Rnej8K9xbYq5K9tTLOpUhDK0tZEIIDG68Vm/JQShbDstjhX0OchsMTPrRch6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789121337;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=b8FGv0j2NwezdLYgCrP+p00qCbnVYI7h7yKn2bwe8TQ=;
	b=H1F6B6MYtvXnZ/agkMvOacd+tKH76JkFEzaVDng9spTb85EKpHus55iqsPnXq+2Z2L4H
	 wNik0qdTSTrbXv1+cmvVKBoJRJUGECrabaiTFQbXNw6U0r1B2Mp+7H8EU2vBEEltgo7Dd
	 lJ+mdkbYeJyKUEdYSb3aeWINJgXZv8KMgBpBKEUx+ybTtD9defmrGnQ7xTSPn7RIiJd2o
	 20y9iZyskGrze/K3T/MlvTJxcSVgKs2g65h5RwV53LKZ37bPBdrzRBD/skB2/a2lYZyxN
	 D9IDVyoVtDP9odKRLafI8/PYKJvNA5Jhh5KTrLges4jsuG9yXO2L8dqmD9onHSpDqPA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789121337;
	bh=b8FGv0j2NwezdLYgCrP+p00qCbnVYI7h7yKn2bwe8TQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rcD2qeqJd/wSgL8aWEHBO42BKdtIL6OkFYt4VLqBm93rq3M6ySqxqiVgM9Yh8AmPt
	 6yMTY+jnv0L8XIS4y1FtsqtX6eZ9Ht5PcqAcz5YAWZAINq+tkbK89hGOrAzSeoCJMJ
	 aJxYwjcvufqzmkU70xLQA7cBq3jKtxLpfwp+LSfNkupATyWKWSCtkGkD6HQL3maVIC
	 PdhrH3GMDp4nF8J0KX7ptBMjib9HzbbJUaSAogxVbDXKyzdgbgqjrwD5Q5PJ8s7Zpy
	 XzcTi9we/dt/XwIIhPbTq3s8GW1fnrrg7lG4aEPEjvTtzevkJZx6e+unFPYecO+Ibh
	 +cFMmyw89uxCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4293181114;
	Fri, 11 Sep 2026 10:08:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EE0129B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:08:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E02E14042D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:08:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x_f_l9qWrmlX for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:08:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8A0E040064
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789121335;
 b=jHVDK22azGpkQKC6lB/x4HURBHsi6k59c8jhKclVNPb8L/IITJOAgkgVGa+TaopHCuRY
 vJt9+WEI18MAc6pAxWZQcjPR72ozInoRlBwJmQGCIBQNj55+59RZEy+oIqQfM5AibZQ0d
 jnw+7AA2ij/LAt/3WlTqzdP9DoTs3505yJ4tGae9OmA5z7GWQulPT73BRTHjBMqM2+zlw
 mRtAbh8G7q2B8IQ1ciNKybkSqRDVrsBsuy0PtZWSDzQk0qrV1RluWi3bq+Am4o+Rh1Qt8
 HS6txawdyUftY5ljG+2kNTYi+/Bq72iyXXHRS0soRv9CbSTl7jMNjxKtKVD/D814vuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789121335;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=b8FGv0j2NwezdLYgCrP+p00qCbnVYI7h7yKn2bwe8TQ=;
 b=fNhIhM3F0gpktg6KeUTGWDvMF3cyWZ9l2j3DT5AX4XUq02cdP5UbjggZ/0QBIn7gmXlS
 CTvxFRiVTY71z6BWzeDlfZ5gouoJ+mYkioNdNRLnvt5s6fN1whPASnvKEghs5eXuVpbxZ
 hFVN65G3GfAES/TZ2OvYw8ARlfT/WCP/OVv4Dji/ZHXxOlFKsybRjWv8XToHhA+33xUBu
 cIGM4aj7qE4DeWrfzQzrHDghchGKzyNt+r+ATDYb1ZQV9KFLmQc2yKhaxeBtpwGiQQEPM
 ikdHlXw1uUk19rsXyM/ZnxLGAZqYwAyfq8zznn3iFZflegXnOS1jmZo1OSvQlHr+Xjg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lJ50xol1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=lJ50xol1
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8A0E040064
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:08:53 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4843e9c5960so657515f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789121332; x=1789726132;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b8FGv0j2NwezdLYgCrP+p00qCbnVYI7h7yKn2bwe8TQ=;
 b=lJ50xol1YgSNzVJC7TGUwxnuUoD23kJ8pa9QwzNtAGKBy3HFam6Mx1DeHhzmwNPYha
 ZFojfIu+8xjudspseFYSyRO3XVEgBmMEa1+6J6wiz82vmZHMtsq7dWIMi7J/Dcw1TGTV
 qwqy/22buHpraK/NpErk6n7HXfLdBpHXpmKl+V0IJwdi3YSJMpYLdzgqU7vtygrhUuiC
 /P6SRIOVu7qQimNdoubEc7I6PkMaMI9KzV36xXnZ4pN0lduG3PJp1ucOk7PG6Zii8r6V
 bZcUv+KtBfd3wF26Q0A09h/1l2zacaGigvIMw8DNl3vALHx2YojNn6oj0M2urnssA6rm
 o/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121332; x=1789726132;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=b8FGv0j2NwezdLYgCrP+p00qCbnVYI7h7yKn2bwe8TQ=;
 b=MQoAZlRyXMhrs1r79oKzx6+mOjiJrH1rSM4WxXMYY4p3sa9D6XSZElTUnawUXAtUrJ
 L6syK4PJKhPiyjVV9fsr3/ysMkRAyIALEzag2x/RYBVblImBn+hPU4LBBiJtGWyvDrFP
 DxVXm4cVQYIprgZMBDOI1PssCzPqLvTYrboXTtk/kLsyw5kYPNm6lEhNlIaBA+fH07L4
 d9Sw+QTarhEgk8u5W6kjIOods7HTj2loGXjy9ZW85ptwkDTBm09G8JTyLr1wgoFweRzb
 cd9vUoXyZQ6guP/+OpVK/4LGCmuZcB9L6q4k7s+KUjGpJuXrEK3iooOa+KrAdKeqkQNU
 hhQg==
X-Gm-Message-State: AFuF++kchsPZfJK/98DuwznRB2AYGDYJCf657+x5uxlH097ul5SUNAcg
 cVSObDG3iwHyRy38vfvKeXRa9uAGQLkvrsILJkEdMpcBjYpMb4BBG5apea39MWksS2OtusT2jlh
 9V6qEggY=
X-Gm-Gg: AYBFou2Iuvn24RT5pmfHvXeYS/qQybOD8CRsiZsSY94DaO5G/bpiSMj+YNjegGcH0DN
 MS/ibzER+CL6HH0HjLRac8nQFrMIKrPagJqZkf3uDrJrI7meKEYpAe8Z3Z4ohUQiPgzHt5IkTCb
 HXsQH+LgVBe8kW7jlPGRtFA2fexkPgEPx7ZhR2DyHX9Obcp5V128Z8Q6OVqctcnXj1TJnaTBfr3
 FdQ7QZaGnkhs1mNmxQPihzsCcU0bHuAXBjVkbjet9f9EjnywDKf5iJcniERAiS/I3ZavJB4AWb/
 9xoBgXabvmkR+TXGHDDZRKRY6dPX+Mzqla2iK1TQzG0AKzCeHQAD26zWPClbOaRSRRfoq3MVa1H
 Iz9afxhAcx+S98K8jOzLmXiihSIotPHXunbrnp5E/4D6eavlq+zDUoohReFSZN6tt/61935j+Zo
 Mg/XjLTkBtXxV0yH0IrW2TiI8HjqmU6qw+rRvnxb7uBbJNL0sds8mEqEkuFCn60dtvUdpIMMPTY
 bvhcpK4jCKcds0sGMbOyd7v
X-Received: by 2002:a05:6000:607:b0:485:b0a2:6e09 with SMTP id
 ffacd0b85a97d-486eafdb449mr3753873f8f.20.1789121331426; 
 Fri, 11 Sep 2026 03:08:51 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ed0fbsm4978390f8f.3.2026.09.11.03.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:08:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20260809013229.444123-1-marek.vasut+renesas@mailbox.org>
References: <20260809013229.444123-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] pci: Iterate over busses using
 uclass_foreach_dev_probe
Message-Id: <178912133089.164375.14956565967993994118.b4-ty@b4>
Date: Fri, 11 Sep 2026 12:08:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1
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

Hi,

On Sun, 09 Aug 2026 03:31:51 +0200, Marek Vasut via U-Boot wrote:
> Iterate over busses using uclass_foreach_dev_probe() instead of ad-hoc
> loop. The uclass_get_device_by_seq(UCLASS_PCI, busnum, &bus) == 0 in
> the ad-hoc loop would break on first controller that does not link up
> in its .probe() function, which is undesired, as it prevents listing
> of PCIe devices on other controllers. Using uclass_get_device_by_seq()
> mitigates that problem, and, at the same time, simplifies the code.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-ufs (u-boot-pci-fixes)

[1/1] pci: Iterate over busses using uclass_foreach_dev_probe
      https://source.denx.de/u-boot/custodians/u-boot-ufs/-/commit/0cc7799c0cd87b103e0efdf1b816fc14f046b250

-- 
Neil

