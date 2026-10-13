Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8CECC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4D4F60741;
	Tue, 13 Oct 2026 14:37:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKYqufzWdr2R; Tue, 13 Oct 2026 14:37:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B3C3D60778
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791902269;
	b=B8/MUb8DA5UG/YCiPLJcrWQMDioMQpPodcaW/LnZodyATtTEQBSiLBnTdF/XX+nPAHk8
	 azNRWeEKdDyChbJOFL/9WAnAptn/XcM3QmhTAae/QDakyOIjS28VIrEF8uMungJsk0DQv
	 DNDul/1+ZapwNR/jxEr90frHFPgc2DIXeaAMNkYajZp6AiqlOOYtphOKWJf11RcAwqA3m
	 EqXDb8lBTK+0AA3GU8Sa6e3bfKXu3Sw/XAO+69uzcyfm7epQsranjmPZaaXD5CkeR5TK7
	 GqS+ilhhhZcgnVX7JyQ4YPMAkDZ6uqulhqSFnHrte5XOyXwwQK23uSJ5P0sR/m2fCmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791902269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wCN+OCL/8qt+E+Op9WtUyOfESDOewMR8TAnVzF3zbgA=;
	b=jB6tiaj5GJzOv3erLrUsDyNQvhHuduBzN3BK3MKuZVjY5QFDCYOGk+ctiCzionFUo3ig
	 QMRRUQD4n5Pjb5mgrqTscQ7vKYMMMyrXdcb3c8NSOqkm/Vist79TPynB7wyB2k/h+e07g
	 77AbQmW3KnG7UqMWLR9bqSmMSDe6pxxBr2shPVeqNioZd8h4ik01BdMJF1ZQaP2PTIIwv
	 q85SRbzQTjhHED5KZhQHuzcIalgj5JSiZcCAr8dZGGE3dEVNjz0EM413cjXesIhnLlWP5
	 eb/8eDDVe9NpgnPbd/2Ztw5vbqx1wFNrBfI2dHq30JpJvwx9qImO8IGK1SVr0jsfDEA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791902269;
	bh=wCN+OCL/8qt+E+Op9WtUyOfESDOewMR8TAnVzF3zbgA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pL2j1gs1LVRk+mewXG7fUEMyWwW+WKAdlbP8VeJJa7eC7PzzHSgeZBA9J4lcxJBBj
	 IHXlJEJ5mAKS08/Cmd87AxpYFEE6FS0B6zTB84vZhOhBBjStcefNDlLQlzvlLsFuuC
	 juTyfkaaL2eyXBjy+0WXqXYWQoPtc3zyWm7GpM39902Oq0rhPlZm5dUyJvtJ1VL0bj
	 EbeidmMKXnLXRHkY6wf6wISRx9uAFb6dGHuvr46QD9/8pwi1Es7CzR7JcTOlgDi+5r
	 4q7uAnx69Je7x4STlzvLNdVUlPhbfnQxgT675i9Gcid3sNu0EEHlGzNCHtIKkMBqPc
	 cf9QVnCZGiwCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3C3D60778;
	Tue, 13 Oct 2026 14:37:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 85E8A2E0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7842F4010F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iHRUqymVjoRN for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:37:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BE79D401EC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791902264;
 b=kjIf3eMonh+jODmgSTqQRWh/BVo1q6+TEL989CMJFiJMu5lQuRxwTaLnVQWuaPtR+8lr
 K6mbSAOkFzTu96MahDghuLP3vFX46xTkj6e7kCkqP2dZwCZTW2DI+6cTn+lQzq52QeWWq
 bcBMfM8ype6MlgqpX9FzulcGIvFowLxNG4xhTvZ2ycRRuq0dKmUAm19Hejg/a+0hDFuN8
 RIioYMY1RuTuup6sZX3k9Tlw3pyNOEbv/aKBMb1WJZwDP8g0HzG5/mq3SUdFe0BJJZmqJ
 GR7vrMGg14zss6CPXpattJNcsKnxIsqq+V+yfHGD5NG6UEyper1ATpv2FOEPTBbO8Cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791902264;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=wCN+OCL/8qt+E+Op9WtUyOfESDOewMR8TAnVzF3zbgA=;
 b=DFffZuS32vM2ptXlaIE3uDAJbMBQqVzp/j66Ujpp+UPiSUQNfhuGSA/pYGA5e6OPIMVT
 Kfjv54Gr+UbqiqswsqLydfo6PYNLfIDqB2PDMHxZ4+Ggha+SEyLeMB2Blg1qRZQdtOxzg
 PhTig29tprmlItZcvKZ+1hDlhYXc1QPjkntpXI0ydqmqDE7s5Xv9suGeaD7+z16ZKY1be
 s/k9/OrgsQA12qh9pURdDVLw71OOZL3CtWh20sV7YSV0evK71FAm/6zI33pE0p09GCsSL
 JwfomLEcxZWA00DyMaMQjY2L6Xt75F+EQ5hVGPABO9wqfGGCTVztnEefi9DiNacmarQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="Pdgx/yth"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=Pdgx/yth
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE79D401EC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:37:44 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-821480f0153so517517a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791902263; x=1792507063;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wCN+OCL/8qt+E+Op9WtUyOfESDOewMR8TAnVzF3zbgA=;
 b=Pdgx/yth7I6g5pb77DBcNu3tZukR/1LTEIa8z3ZC2JA+OefUQHIjlZ+ifVUVSlX1Sc
 BXlY1tf7LUV6OAhYYJjAWJz9NHQeI7rCx9oz33ynG8gxBzsJhASC749w1ywzLnocoYjH
 3EgcNI4tyKbzz3/xYBOrQjNZofETZgkBNjJ/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791902263; x=1792507063;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wCN+OCL/8qt+E+Op9WtUyOfESDOewMR8TAnVzF3zbgA=;
 b=HM+JbHeyzqSKcdvxR/hS2CwOhh/q5zkmxu+OM9uDUtVZZC1NwZSMS/3BzRvjjE5Ogk
 Vk18wx4GrXrQ8qfk4HhbeCqjvJS/INHAkpdQqu8IPsWH8R6Do+0noj9TNB8rNlStCNlH
 7yV/sfnZBjUchxuji+uf9TSyS+tsQuvs/k9/436gJsUuTrPggHEtBl218sBat1NhrQI7
 0vIUxZON8YjHSkutZPjdUW8zmtDPas0wkRrVZFmQVVsy/BjRFz35V/sTp8cEvmYUmx12
 oMoYyPnjjeTQqWANXWhO7SQWiB3+atEFeCjft+CqpWtUJ2B2qkrdGTZwWQ36HB9mudV3
 wy5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzk2ATjEXvyxQpKZAfG148KKLdOec3tu5xtk3ZC2dccgnBN5x58cLO9GGryv4BrcwMuVMZ4Y2k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJtUcg9K0ZhvKqs02PGEaFJo0zQjAZxhNeNoMG/KS/FqItRARLM
 dTLDiKH4rMmwCIYHiBM/TSQWlpImP+fcQidvzi6NyjI0d3zBODTvjmQKJ6qwcjCGWN4=
X-Gm-Gg: AYBFou1hdNnutIsvtcSEQ8PlnQ02CD5lFI9/xkTXj4dpXyAbuL1wOrfXAe/WbgI+08e
 25uHuPic4vF1IPd2i5HaBNeRoinkQV+70Ah3Vyfh3+i4Drkvw65GGv2Fz1n4YvBp8RYTVCqOZbi
 Vo3JSuo0+GyTZNoqnncgw27cNuUd6Sl8FJ9kvkkeviejU5+Ww3sZkq135Qd5HH54PKk906LZVwd
 vaRothKaBc4AgeMm0OPk2x+OmIMOA6YKiPLhEjeIxNSyrBOG3JDSU+9DRH28P8+SkZlB0bB6yNK
 j3GQpDqj496PYrxwf8/nTmhC75sllXvB3HL1cZt+nnRjvrJ7DMZ+2wrGLJTU6hLJ+6P5AwM/Qwb
 +EXX3miN4FKUo+JZYzTNn+1+lIDOVQVSBuTC/frK59LM/MXPCHhVB0PeYqwu20HGznXvwTyg9+8
 Zp+bkkJg0OYQMO68UTeDZ1M1A9Q99+SBhSCxm76/D3yGnyMFFe9R+HAYFLGt0KbqBRVYg2xVvhS
 BoF7tQSGP6Fp9zuRQ8lDsUO41nxgZfoOAYJj4MPGdpFvktO+7LWTFJ3i9I+a/QXUGHQYyaDdHDt
 1IiOX0Od8+8xcJQkPw==
X-Received: by 2002:a05:6830:6a14:b0:7fa:ab72:9df9 with SMTP id
 46e09a7af769-83095f0fbd2mr12829685a34.17.1791902263433; 
 Tue, 13 Oct 2026 07:37:43 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-83039a3e016sm12363996a34.17.2026.10.13.07.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:37:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <36787fa7-d029-4ecf-9f2c-0432a2a45bde@linaro.org>
References: <36787fa7-d029-4ecf-9f2c-0432a2a45bde@linaro.org>
Subject: Re: [PULL] Please pull u-boot-interconnect-next-20261012
Message-Id: <179190226286.4042530.9813820394023022985.b4-ty@konsulko.com>
Date: Tue, 13 Oct 2026 08:37:42 -0600
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

On Mon, 12 Oct 2026 17:48:15 +0200, Neil Armstrong wrote:

> Please pull this into next to support Qualcomm SC7280 & QCS8300 interconnect drivers.
> 
> Thanks,
> Neil
> 
> The following changes since commit e1dcad5512b81009eaf7e472c20a8a15db8c4a0e:
> 
>    Azure: Switch u-boot-test-hooks to git.u-boot-project.org (2026-10-07 19:35:44 -0600)
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


