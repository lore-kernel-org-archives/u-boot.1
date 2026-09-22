Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E9AC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 13:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCFF440776;
	Tue, 22 Sep 2026 13:43:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GUJDuhxlUj51; Tue, 22 Sep 2026 13:43:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 337E040801
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790084617;
	b=QQN/NTK9qNhcMkALJKh/ecbkZDxVQRBaspsqiij7ApNsPQ1H5qGI6RXOkgbZ4bE81zJg
	 ViNTZbbThsQJV56AXypkuA7FGmH2XMvrzAb/hAxaniSJXz5Cp45G6wCsb7ankrer6kkO8
	 utIV8c87+5EVJteVwd8yeFSWUm/ewZNnTF3uj3+qpuz3lTBzNa47NIjyGj797kxpX59ai
	 Emut8/nzDY6LgAo5Y6Se2LkBqdlFaBEsXMhkqouBk26Ze2yvVwzZT4JLPHWq1ITDvvW3j
	 BDAYUrY6l+6BgczMQTTyc564khYi7ad7e5cGmrLMqtvnWuD1qU1hSOY2H/sB6kUeUnQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790084617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K7rrvFSZ4BcFVuJef0Y0qs0mIkWbHn7Rh+ZkUw9LpFY=;
	b=XCuvBjff9fV8NURZ6RFqDwFQJWfXJSVnWUXnTVeU02YeigppWMntjsxWnazQ+RiCq3oV
	 +Nu3ihDpY/3cNi1R8JvgskdOV06RVguL2WaKGCqpXqkFTMDdn4KYYBM77FTIQbGVyKibL
	 FbqNl0swKH6LzxCJ0GzDK3bB2BmHVEtOejEThnz8zsMcgbP4GXvQn+p6U6bUH0tZbByQs
	 KKQUsElqw/naQXoxBmpneHBoHUwb8ZTQNLsbH2Hqa/A1/E2gFM3k+OEQ8KjjtiyfEskYW
	 hA4iZAtAh6oZmfB/u4tcGdKk+e6Tq2+OH0upfyM74Q9Ean6UFIF2ykJzOWaq8tT7RMQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790084617;
	bh=K7rrvFSZ4BcFVuJef0Y0qs0mIkWbHn7Rh+ZkUw9LpFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dhcQr6M4YiWwc7R0Wsuz35CYKiPeSNhVA8wNP0XWFfTq2m1oyl21jg6kzTtBz6HSj
	 2gorApCgnTFOowEndSyMXoAAW87B2i2nfGzZFdxilIBrdxBFx2lw6RnnRsf8OLiCFU
	 sTDf5xRvpLlNLjm1+Irh+tcQt9+w5iCYP/8fdHgg/1uo6zDXnaAHJEsQxkhpLzw/MG
	 SHiOBHsNFuxNR7cG3yvnWzHlUTDn7J9GZXGPEggjwSAN6RFlPJkSOnFlr0/MJxsFqH
	 EbYXLurqEDsNeMl92Bmp4MobA33P3GTNVLL8GLn1zaQ+dtbxsceazK8i2VAMZSswnI
	 Kv4LMdzbnopqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 337E040801;
	Tue, 22 Sep 2026 13:43:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A2DBED1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93EC160628
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HQTQGTfRGaV6 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 13:43:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A1932605DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:36::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790084613;
 b=MWL3kr6QHDFY4yeub4ZgiQiF2WSEn2UrulsKfBPlNcyeMQ2VPM/s/Q7rQJ+2DQJmRfaS
 BDVHHGU4kHG2cTf0SEnCdsmrnvyxEvFrFxr+p6KX/6Lo337+ICtsmlSF9JEtM+yvk7pHw
 5QOtzYWLBsd6yoeKs5EJJ/uB9mkfonGhf+7w0Fl3jifj18NtC67RQcy6FYMSKnW1G6Dax
 ozQpUa0hYraOQv920zK8PSi/LmyQQUccT2yTHtILYT/GAHZqJpJlZHyT97Tgrx//I7E2j
 fG7Y7pfO0v7tdtewU+R6XrtxpdaaWt/QBzOb7IrzChQ0U7imxy9EJwbPZuHgwNHQtUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790084613;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=K7rrvFSZ4BcFVuJef0Y0qs0mIkWbHn7Rh+ZkUw9LpFY=;
 b=rZjL7UQ6LtKV+Ms5ygLC0RcuQdY2ZvgkOiTQTR+WsT0bk8lVFNIpY3laPBOUojAUjuvt
 pjcU3faYjOvYAg7qPTAEz1+2gMMB/Np3zsqlP7A+oiKmMHdeB9DAkBIapfYGb6DdVGYog
 mvUlXU8pFMKRF0x2yGriO5Ow3+jzXNH7ImjiHZ9eHurTyNetaTaWqHXjV781UvFxqSfdG
 E7sIIvrVedP1gprPWfCbAtPoquJAyWN36irLMpqaeA0EMtgD7FY6lUHZOicuAjIF0NUR7
 MRQfrdKMaFeM+SDJ57ehZ9OlpWP8/j8TieF/tgdr3YGlNY1qHojFl4hpv28KLRpcAng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=c8oimolF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:36::10; helo=mail-lf2-x10.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=c8oimolF
Received: from mail-lf2-x10.google.com (mail-lf2-x10.google.com
 [IPv6:2a00:1450:4864:36::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1932605DF
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 13:43:31 +0000 (UTC)
Received: by mail-lf2-x10.google.com with SMTP id
 2adb3069b0e04-5b5e4f13d77so4714364e87.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790084609; cv=none;
 d=google.com; s=arc-20260327;
 b=n0zN7ifKSvwz7sY5DIo1cvTjjBNHKizoE4TnWBwUmgdluEa/RlIHsYqUCN5eka7v2V
 1PivqBQXQ14mYJ3raus3ZJYpw7yFpcEsq5Q4zZDCRA4xIVuq/moBDHEzdq622gKL09I6
 58zUKRuV1qALEGMblhXp7Ch76Sw9xD7Z7RPey8JhP4QiMPcb9oY1VVzGrpYo7iMZfnQv
 Hwf8pQYypoGmk9L7gPNCYd05Wp8nGyZNVG5e6Bw6WTkUdCTMdTqXSv0CjZfhOuhHKJFl
 f11kLqqQgubcpXiY8gx30sTSkdLzZRKuYgNu7w53v6r08XxlwFFswjG0emc0L6CLIASZ
 l13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K7rrvFSZ4BcFVuJef0Y0qs0mIkWbHn7Rh+ZkUw9LpFY=;
 fh=c6NGCyoVJu4GCuOStOxD7CnixsHmwJSBpgGcyXASkl8=;
 b=moSNZ63A5GIHEGLv1EhN1AAWfQFdpWkJnd6qoip2hpGFcrz2Itn6j9Iw65xaL5Ix35
 /YeLwEC4OF9m7411P12H2EsR67xHuvfmMPrQLXZS5ZrarQ/SUDGjCVoQV0bYbG5QrKB5
 S8gWqqKizA3XzFepyG9JFZ+GxJHbFv0TGQAqsSbQKhXtsItFgIefMMgm8BLDt+0mkHi9
 oLa4fv8Scf/dmFfO5ztwEqxK6XDIMvT1dWpMhA9gyTGKeGR41r0wSSStWTNFVJ3wEJne
 AUOhPzzvtKa0a2bN9lJRU0ZNBybEGVTbBO0kUYqaEmbtWOxX4CQfAui5ZWhCbICsf/HG
 Xdlw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790084609; x=1790689409;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K7rrvFSZ4BcFVuJef0Y0qs0mIkWbHn7Rh+ZkUw9LpFY=;
 b=c8oimolFjXgp9kVnVAT0BRXtYBbuUD7qoQatPFW/x/AfAZfKAG8ERAureEh49vMa9R
 sfL1haGpfoRsXwvlNU3R76txUvmA59P/+d4kg7GPIxZ37g6NeH8GuE8ECqg1dA3ilRNE
 K83/x6kvL1J3mfs5SFFRzcYYq39WoYrGvjz01nbBDnZ5TULPOKIHdfUU+BkAN9HiayGQ
 NFXA1CjcAOtKjcqRRzmaAna+FqwRLyHag7FNU7jZ+eiZvb9EDoQm1HgpOe4VUZ8jSSch
 FZHjBrH4QHz/FAETZZ8Q1aEiJbsbrzoVbr2Wtv66aEam1IavFvQ53GjtRt+iaGoRqn2d
 nd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790084609; x=1790689409;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K7rrvFSZ4BcFVuJef0Y0qs0mIkWbHn7Rh+ZkUw9LpFY=;
 b=J7tDRUZCfUxAc9OITtGPRTpP9NE8lvzOpOy8IuLrO3DdKD3pO88XoFccmX1OecPsbx
 /FUnOafryj36+7qDiNAj1RucoBe8bIeilU1DYWweDqy5Y7xUNFt45cpjogHF915Wyg/M
 9IwsYKfBGlmvScB3MRPYE53TLW9mgA6xOtmPiQuLLlVjr/82Vi0pO6j/dmK6OYLrOYIe
 0qbs/Q8Yn8VKxNqeD0p2h4z5K2X4FQjPpajXesDPXs1/BDc+ZKkmSsSStENYZO+w6Jm9
 RcsEsOEUjnTj+Z8cNUgUv9MqJyIZUmF7JnK5s4gm+WbvDylewVb2aLPdTnXJPR1nzirU
 GCLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzudZlR82yQlH7pfJJDGMsu6qzcYyqulsrPkbQEzNNSVjvTk6ug4vRGAVH8k+yBt3N9rUQVSrA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kABIlFiUvXazhwKpNlqukjSxZu6gUowrcGQsqHv5ftbcR6lvCK
 VcOk+5KsyeUkRkN/wLpLG6gXzxQn/VwN2/gbjM3CkYUz2G9IKmR7vVFDMYlAkulQeEPavwBS2fp
 KzMOw26GfZuQqJTnWxMwUzfRUceTQNX0=
X-Gm-Gg: AYBFou3685V5JkKdR8N10fl0zkrXqBjiTbGw4v9KuIOD0uuLglVu0zxplRobpN9nSKk
 7XS/gH2WNQDoHTM7geQE2qQ1Fb8P/tY02/Zzjw0RtS6LeVT40X4bPYKnzvQ3SJQzvNnh/FoqkTh
 RuviRm13WIQImjHPr0B/PmyB12/ITUYlIjH3OqOdbTFUFbkhZrVXornJvmbIWNhCenb4f6luCBH
 XAhACOwWsQlHuPkUZLusSYSLAzEfbnn9nBziNzNMtHO5aE+tMNQgHxp16kq9UZQuWnB8eSse+eT
 n8qAIj1cYK0aPjJcr8x/T7l6QazcAQFo362RKJlgXZiYwE1nDJuoQzCWXdJUKREYoCPDwiH5MeF
 DjZbDVb8QPpCJsz84gMI5lyUD3Oww9wJu/ccZJvN5Dma6
X-Received: by 2002:a05:6512:250d:b0:5b6:1a7c:1f with SMTP id
 2adb3069b0e04-5b8c184e32bmr5198211e87.34.1790084608541; Tue, 22 Sep 2026
 06:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260922-imx91qsb-v1-0-8f8b0ae23af4@nxp.com>
 <20260922-imx91qsb-v1-1-8f8b0ae23af4@nxp.com>
In-Reply-To: <20260922-imx91qsb-v1-1-8f8b0ae23af4@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 22 Sep 2026 10:43:16 -0300
X-Gm-Features: AclHuK_y7FzVeaXlCk3hPAxPJXd3fUFWhsQ32-HqZISp-GZRW-Z7SsCIXXkYuS8
Message-ID: <CAOMZO5CyZ_MTgXhfx=Y+qJ8wfLvV+gAT_T0Di2Ld2+RSegqxeA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] arm: dts: imx91-9x9-qsb: add U-Boot specific dtsi
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Joy Zou <joy.zou@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Johan Jonker <jbx6244@gmail.com>, Ye Li <ye.li@nxp.com>,
 Joseph Guo <qijian.guo@nxp.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Alice,

On Mon, Sep 21, 2026 at 11:57=E2=80=AFPM <alice.guo@oss.nxp.com> wrote:
>
> From: Joy Zou <joy.zou@nxp.com>
>
> Add the U-Boot specific device tree overlay for the i.MX91 9x9 Quick Star=
t
> Board.
>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi | 184 +++++++++++++++++++++++++++=
++++++
>  1 file changed, 184 insertions(+)

That's a massive number of lines.

Please make an effort to upstream as much as possible to the Linux
kernel devicetree.
