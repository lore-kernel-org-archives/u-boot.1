Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DFEC54FD4
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 20:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0A03607FD;
	Wed, 29 Jul 2026 20:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDm4K8SjbaGH; Wed, 29 Jul 2026 20:33:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E2A2A6077A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785357198;
	bh=dkKnBdK1gAVyrXlXkH94hFN4P6gXQi9loxUYVlaseqU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WSdqZS5ldnPxQesfbTVoq5w6IEWv86iDEdgZabJAts7qp8kRoTG+cw1rYxvsBB1E5
	 0dWUP0wF4toj91SzsPhcWakRaLR1EGe7oRtGmZBM0I8K8rdEZCYqt3GgfzR5zxeCpl
	 pav6UfDUmXysq1+RJj862mID830iDr1EGHc2BwgB2x0oaYFgJW5EnqxyNUfD/Da2mM
	 1FGGbOmHxFZQLSA87DDA0XJ8vLAczRP1K2lerRkbwxiBeKBai26oGMz1iYRViGp3x7
	 NjUzdtDNxzXlRd+f1rndHjrAtvE/0ZR1PaGzpXNkhFNUWqcx+4WlhWXCqA9zafWBWw
	 Nn9566XoRwjlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2A2A6077A;
	Wed, 29 Jul 2026 20:33:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D114026E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C28CB400C0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dM0JeXC1k2pg for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 20:33:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1ABC34009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1ABC34009C
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1ABC34009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 20:33:10 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6ab021f1daeso572536eaf.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785357190; x=1785961990;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dkKnBdK1gAVyrXlXkH94hFN4P6gXQi9loxUYVlaseqU=;
 b=eu2O6ucBYtIdg8J6lii37pJlQO/ffp/slQnjV1EbL3hzVdLhCNfKiMQTdX6vN96sJH
 tjo+Lr0IoVMlrPTNRT8WYO81UmPheM48LeBVXgkaZOP+Yv/E2Fy9t7Osnx9qHjGbApBv
 VJAz/JqvK2q8qeS+mljwEZj16JA3vUw+AmgM3nn1z+fQtypPt0bDLfamOT28FwNXD5ak
 AJH3ZfvoymWtyxIC2fDZpTiKlNUKzcZo8K5g6w4qrZYA183SmyBb/rIhbZk5SWczfQgJ
 w19T+lDZBPOzjdXlVmoDL0vvl/FCeVTgW1/J18EUx9XPq8KDg6M6DQMaxjWMMnCHXVNM
 xEmg==
X-Gm-Message-State: AOJu0Yz6vPlQdYaGmt1ZwxTxuocEemSxNasuJADJEaB3Vq46HsjHcjDs
 hAz/vcdirA+6r+3KwaZCpSvqslsy6Tvf5Vx/0KcCiFqbt5dviBs9RHgilbq6nh3vKmmoI3BZFNM
 TRbTwl7M=
X-Gm-Gg: AR+sD10EEgsbjqKAPOKqHxTTfUndTMKDjscYU/nHFkgGfLhbrU5POV9P0fCdYDzYUSe
 pCVPFtcO5T3ENPNVkhi+ZMQSnsh/uMFV0h2LczOY/NyGqRAB4nn193u64p8em2RY3MnVIWrFINP
 aLWpa5mYd7Ou42PmvAaNGOUrJktjDX/YHpbsfPDTfXgsM1mEf5IKnIaXCVDdsvElhXNIJJe3ucl
 sGJp6wEF67ObUqrN3m6HJOa45ov24sU9kfIWD7mEGv3mgi3UHBTdCcIYuyJ7/YTPn4cQEWQ205a
 0Job8cDbDduFHXj0UHSV17mfLkh4UoM/pci7rtBQm2VAcFXL5grp6hob1xjeu+gglgvF5qtlc/h
 6RgKp6Cvj0VKQrNPH9JeMZAHlo9JaCy/5ltw9mBKaLEd0Po/tJiUMVpFPYZCYO21byL2BUlKtGR
 Z3Ivq/QosmkQ4BOF3w4cE+HIbjvylw7A5QPFnKu5YhSkrPBWvBecbaLZMsSmuV+3HElns8eTNi4
 Ldqn3KI7G4bxK73bh53xutUi2H5fpKmIEeJAs0y2qwVXsZHJvovR2C3Z/wkLqLxMUP6xtKBBZkR
 JyUNfXPf
X-Received: by 2002:a05:6820:a0a:b0:6a1:1a19:3f9a with SMTP id
 006d021491bc7-6acbb7ecb8cmr29949eaf.52.1785357190081; 
 Wed, 29 Jul 2026 13:33:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4588688e692sm3420221fac.14.2026.07.29.13.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:33:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Cc: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260707220257.252911-1-trini@konsulko.com>
References: <20260707220257.252911-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: qcom: Update ipq5424-rdp466-u-boot.dtsi for
 v7.1-dts changes
Message-Id: <178535718906.1975967.17858636708739921339.b4-ty@konsulko.com>
Date: Wed, 29 Jul 2026 14:33:09 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785357190; x=1785961990;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dkKnBdK1gAVyrXlXkH94hFN4P6gXQi9loxUYVlaseqU=;
 b=giioN3JIyzVUR4a9bHmJtNpHrikUjCbKFsi7aLHOaWloQfFWbjB1UWT/+CncCsKI2u
 4G9mCHL4YPRE/P6kH38kO2C6dT8Escn6Pl42wPrVUrw4h+B1jALROebi3O4FSEs+dcbz
 a9XPDxXXY6ZQsYu3TskewqXnbldJ9WTKQ8ags=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=giioN3JI
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue, 07 Jul 2026 16:02:57 -0600, Tom Rini wrote:

> Once we move to the v7.0-dts tag, we get a failure to build of:
> dts/upstream/src/arm64/qcom/ipq5424.dtsi:556.21-573.5: ERROR (phandle_references): /soc@0/mmc@7804000: Reference to non-existent node or label "sdc_default_state"
> 
>   also defined at arch/arm/dts/ipq5424-rdp466-u-boot.dtsi:20.8-39.4
> ERROR: Input tree has errors, aborting (use -f to force output)
> 
> Looking over the changes, this appears to be what's required to keep the
> platform functioning as expected.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] arm: qcom: Update ipq5424-rdp466-u-boot.dtsi for v7.1-dts changes
      commit: b9b104e8ddaa81c887872ed078ab17fb39d3465e
-- 
Tom


