Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6728CA6009
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FD4B60B7C;
	Wed,  7 Oct 2026 22:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Zc8G525QiQy; Wed,  7 Oct 2026 22:16:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 80EE260897
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411396;
	b=RqeuuexD61TIHuJFxLNLu4gspfo9ZLMTsbZs7dUSSxUD6Ib+AVEA0WQB8q7D/s68E7N4
	 8aqecu+NOqgZ+Gv5VzKWxF3uwj3igNckOQlupkVhRNb+/ioxp1hQHYP4UAaSqzPCK4r1K
	 unUvtl2mYQ99DrofpweGnsq4R8u1kzb9EGlFB0oZ+ROBLdDYT/Yszg4f2rsVjYNzMNNbr
	 5lUKVxRIM3EBQ7/pTQ4fP0VYPDRcAslH7v/MDitkvOT93u25KmkVR9HC5tm6u60XTbY+P
	 kcl+pMwFRzymUAg0uf6Zhqlh2r7LtTGPGOJiTI9AWi6DpOYH6KtguX91dZIRGHvbRvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411396;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dPQugE4Zep61evj2WGs77FkcXwlSIXa8CM2aJFs5vU0=;
	b=mJFuAmsrmaGCtjJhvpUQkM+2aFPaLH168z0MExeCDv+Xq0ML9StVdlVx2Bk+TF/fGpZC
	 lececkBq7x5GnDMh0YPX8fiLWxqjQRkWaZrMZm+Is57Rv8luEb8hFcYSYxaXwuB8quVqp
	 4qwZEjCptUoVr10y25TB3+LQP38ZDE01NqkNsm+r7p/EVUOPZMn+iLrwGhZQqzf8OcHsx
	 Fdzuo/3ZHYwq5OngYI38sQwW7TW1klvplSZqXl10pR+HN9Pek9dDE4S2is+qZsHzQnZJe
	 arVpYpomegeY5yjWjSDwQuxCRkPo04KO1ru4rQ7+HPRh3iwNDc9XMEMlxlv6xL+FH/g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411396;
	bh=dPQugE4Zep61evj2WGs77FkcXwlSIXa8CM2aJFs5vU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fpG+dCnb1n23YNAmnWisDSNqX2Rjtis20jy2DlwQDvR8otT/I534Zua4RQl1vPZEb
	 yW55b3It89aZvu+2vfFQTAYO6WUSgvTWvkIgt+Rn+VaCGl8HjZlSDARcPk675HFqcz
	 KV/O/tHagYxmxDBHBJd/J4DJJVN6m/vRJ43RouPUJdbOqsPmUVA2mwaoP7scXtzCqH
	 CZEx2vnstKIYoxxbfQyd23eiCyAfQVGY3UhS37ejUZbAlNSo6QjL8WH9dhO6nACpO2
	 FpvPk+45PtMN29mSv26rkmSophV8+c5gqznULqrdyVITqKcpZAs+DlunynW5w8khSk
	 hXBFP4YgOvlIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80EE260897;
	Wed,  7 Oct 2026 22:16:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E9F132F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3EF5D40362
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:55:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZmXu-fBq7fc for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 20:55:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5D0CC4004A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791406550;
 b=e+WWA+kT7rXnl5HR2z/tJsKQzm3zGr5uZOQ/oyZFo0KB71bwpRCKa1OVTtkPn8LV5Gr2
 LaGBH5ZgRkcka7UgwX6YJtVPRPlQ4vN75tZn2b4Q7ftndjxtKCkq2Lyu5HwJulRN/FcVn
 nRoSHpzcdSrVaAKxaHNUyGX2lSBQex1GfRaIrZLlB8q9zN+bqaGSXMQSJnrrYJU/WMST9
 UO1RiooGa1QCQnhVwDIPDSkW8aDpAnCesKZdufiuQgPnxyB7T2ixpgl8cC2S2yW27x2Z7
 ppi3VtKyNI0yEkvobe/xn9S5KZ5rQoPMPowjlY9ql4QlrcevkzZqDrfO15tyCVZY//Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791406550;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=dPQugE4Zep61evj2WGs77FkcXwlSIXa8CM2aJFs5vU0=;
 b=iocLxIkBI8m4P07RFk++NdD7AdX4AbOhyucuMYGEfNHrm2xpApoBqG8GMNqRgmFtG4Uj
 ttGReViVfeT0kh64Vf5Xg88wApYFPao32rThRMu7hlezIjRHN/DqiUH4XyYj3g+5HA9M3
 auYPPBJvMH/hqt8c4gmnlKq6NL7rOfoHRcjApwzpS325vnB2VoPYZtM6p3yABPW4S+Axi
 jLxAdDvaoKR0Pyuk9s5pnHBbaFdnGTrpSLdn56n7X+jgbsfnINtiJ8N8u821iYnLeW9b3
 LteSJpMooZllorh+bCOmFyu7jMjnxcV0WGaF30ZU85gdF058MhqbRycLpC7rX4iGrEg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=o6hdcUDx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1235; helo=mail-dl1-x1235.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=o6hdcUDx
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D0CC4004A
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 20:55:49 +0000 (UTC)
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so2399974c88.1
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 13:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791406549; x=1792011349;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dPQugE4Zep61evj2WGs77FkcXwlSIXa8CM2aJFs5vU0=;
 b=o6hdcUDxuvo7P/F2dVl4YTeU1adHdodu8lMAeA/asxRCUZNMshXyX1AAIeiEfxGXN9
 L13trdY+KXEDcB/t8l9lpJoNfwp6uYPQQqnqJT3r5YE0EVnljSc/xYdbL9Z7Z+GSGq2Q
 JbUrXPvUvjSp2qBsyda84G27SU5O0XiZ71sj+u7QVeuMG7F/SLSgjsgjf4nDCulq9Bf2
 3QIqx5X8D1AEdWJOgHxXFVgxVpcTXUxg0COQGn9qJTYLVAZqe9fM9Ru+m4hadLCSz+Y1
 seqcr6Qz329OVZDptGCkWIfbAIhyctHAsKH9wftWo6/DlBiM/p5skr3Q9rR4bXYW2VuT
 aQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791406549; x=1792011349;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dPQugE4Zep61evj2WGs77FkcXwlSIXa8CM2aJFs5vU0=;
 b=Zyn1SlN9VlfR8I5iJebeQ/JFRWn0Zhq+sJm1r1uQf2M/NdI6O36LjvVv/Z0Cf0cnnp
 1S/N26w7C6qHJYaynaNIp3HuV1v7yUJMdpgs+rSxsDsc/dQfM2r/c2xNBgLYOF0PK7yI
 Y1rIiSOpBl8FlxJkvXkUCMbwNBmYFNTTCOd/8RikW15AlbSRm3V75mz9dQsBqOkb73YS
 UlMISmiTCGbFtyYEvAd13srCJJ2WK7kylZ8JQvidBWQAhHG/oqQxn//KPg95x3SmeRd0
 bsKS9RGmqiXGTd6sDZa6mBGREfzg3nhJ0mE9zlsG95j1kcCTp5BrwImOSNGYVrhNCeBQ
 x4CQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8Pit7K/TJrUyLdiw8bxaTI2m5fJy+QqvQw+z1J/PU0eBtnxfsUkfq4kPr6II3wUwcrvsX5WY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l2DNi3hJ62L1aD0BeEXvlW1voG27r/F2/6DuqXgwk0WGcP99DY
 h4zAFqPRsE2F2joOEol0nCaIPKcO3zfeqDaLJ5tfaWfvzOF/OGUPhyVE
X-Gm-Gg: AYBFou3jBerjfFuqZ7k5ARUD67jEPyJV0emgwH5MxRPpMIGTRq/E7WCDMAMhoxqrmwJ
 yaIVPHIZSDr78WU7vikEa+UVXo9j4zBG4o5WQbUro+SRFvJhjICVmtUacDDrxt6EdZ5BwnpasdN
 AU9Obz4sBy6+n/nILCj5bv3ehpZUN8d+xRq2lPlD8Ah97WNu2wURhJj+1YwAUDhH/9+MQUHBXXG
 FNEJCHgrS63dFGugBtcO8oiUPNyHv8Jt0ymgkm9CAHAeOm1m/lk9iBFZZGm/EiO7RU4zUC+Qwn+
 V+RstIRQQ3qZCAP+fZUnvI1ai+h8j7U/LU3IXQHq2maJ2LYyvmToo5LXHKxzhLcxn7mSpTbdXVQ
 NNZrzreFHZ8utcFMgnBdugpsek6QXmfXzfSYS+GLyIl6VTcwT5BpjCsk7xwUg+C/8brL7IQf3ox
 2Bzfy5mA9scGGZW30XSjsxl/2XzW0ax8b/6oEfXuV8XNO/110bUfkp3oBKhPLKaAL6F4AF5L4=
X-Received: by 2002:a05:701b:21cd:b0:160:afff:53e3 with SMTP id
 a92af1059eb24-162079a6ca5mr4012603c88.29.1791406548472; 
 Wed, 07 Oct 2026 13:55:48 -0700 (PDT)
Received: from google.com ([118.150.148.19]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-163e3c5bed6sm3546410c88.7.2026.10.07.13.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 13:55:48 -0700 (PDT)
Date: Thu, 8 Oct 2026 04:55:44 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com
Cc: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org,
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] Azure: Switch u-boot-test-hooks to git.u-boot-project.org
Message-ID: <asaxtYwTME__VvFL@google.com>
References: <20261007204234.1081107-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007204234.1081107-1-visitorckw@gmail.com>
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

On Wed, Oct 07, 2026 at 08:42:34PM +0000, Kuan-Wei Chiu wrote:
> Azure pipelines still clones u-boot-test-hooks from the github mirror,
> which is missing the recent qemu arm64 9P device setup and causes the
> 9P test to fail to find a 9P device. Switch it to
> git.u-boot-project.org like gitlab CI.
> 

Reported-by: Tom Rini <trini@konsulko.com>
Closes: https://lore.kernel.org/u-boot/20261007195951.GE3079290@bill-the-cat

> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  .azure-pipelines.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 5bda11a0309..d88dc35dea1 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -279,7 +279,7 @@ stages:
>            # the below corresponds to .gitlab-ci.yml "before_script"
>            cd \${WORK_DIR}
>            git config --global --add safe.directory \${WORK_DIR}
> -          git clone --depth=1 https://github.com/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
> +          git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
>            # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
>            # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
>            ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
> -- 
> 2.56.0.360.g66cac248cb-goog
> 
