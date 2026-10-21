Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD0606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x4+G9TF7;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qJriUZOy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D0B28118C;
	Wed, 21 Oct 2026 14:48:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3_ZLASyp6Uc1; Wed, 21 Oct 2026 14:48:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B81481182
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792594097;
	b=MhCpA3Si1or33TpyRpMzJjuOUIKpaJNmc+fuDnvPCzinvihR1Mwgn7rNvTf8ybw5vXSn
	 UDezT3SjmC44xBiX4Ny4EJ6kffzSKXs1DPWWZzCsFALQQgi4WKiJMbku5D0OtC5OcPFp4
	 IYFafu15xHw4QAY5y+eDRjBpci0VlgeHi3z6VFxYYTKKlcbboLtqv5ZQE2Z6nWuBmxNSD
	 bSkAj8g0ou0AMgk+SZSrQwhLSazRHB1pb4TZmnnVVv4kuZKknUEi0U47A6IvvHbKgeBef
	 CNjlVG6GV3Opdz+sK2wQs2G+Kxog52A36+A6HG+wVtnfEPs58mk/CWGfM+ukPHeiGNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792594097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4r0EtgcxqhaEJzKXt8BfJ00DyZK5tLzl31XFTzOS8Qw=;
	b=qGgBxrq0E6Srh5L73aM7oj6I19wGBT2KZ/nB/CEBBLpwciKsdkTjJGREaS5gja8mk//A
	 wPJR4hXPOKb7Lw0rEdWMR4hATi29LMq6to8EV7tqzM85l+XCJU/pBlw7oSsudmWXmzUTk
	 wfRkjt80koIYgGgqyewFU6MMBImprq79lhGKXIUHqdipwQdWuenH+caUFw/umH7+Ok9zm
	 lh8NwvFmC0xAsKNPcsNIwwxCnAJzOyQGxQBm8dpKGfLG1v0mmsl+Udblc2ZdF91ujq3Lc
	 Lo6DCyWGjlMnsFxBGwKJa0nligqGalEsYJGM71dSBIdFzp4c3F3WAipd9rR3rrbKQtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792594097;
	bh=4r0EtgcxqhaEJzKXt8BfJ00DyZK5tLzl31XFTzOS8Qw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x4+G9TF7HPEd9UoVJ/HopJbFg7TWkGpus5O6Tm+iD5IL1VH8QV4WFR1h+LDwgq9MS
	 WoQafbVS3pfj7dpT89/1bkTOr0K1hbcFGrKn2GVNo8wNPo720kq7RVlIqPUdcmleTi
	 nqmjJxpz8uVZLDRbFTwxbTRSeaD3ZYnrSSBSIu4Lmn1+ZdN2wBgG8UhUHo7EQtVIn4
	 cL0mddt/pNLAJeuPaAKRKQc8FYEwEH9Qx7OPnd7Fd+7eqaQJ3zMGydOMUx5eQKEjIw
	 bHgUXdh6uJgPbYW0olJnTSA+s1CSbT2vYyJfdZVjA+Ix7UBaCYOAn4E2nOqhq8ywjH
	 opvL/4UYo3DAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B81481182;
	Wed, 21 Oct 2026 14:48:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C71A923A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B922440613
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o7Wzys_SKtZm for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:24:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CDA9D4069F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792589043;
 b=JvsNSAN9YCVUL+0EB44OEkzca8GeNaUkuEY1oo5EUp5d1IyEcXvKvTmhmjQkJBoYPyzl
 R0q6M7/EfvayB2aiM+RXpi9PYlvUAdvthgD9z/eXcgQI3zkOd87Gf2nYdTNtP6v2t1Dfg
 39TmmI7bbh8UZGUoGy9tfVOiTZ7DFs8WuVt9bQp909/Tdg/g8wL8zfoXFQN65Oqb95rlH
 E017T81d13Tuce4z8JSOIERGc2GoI809je2gbgI/AUudD36R66rK6bSopcGSEh56q5F0u
 z+JHFgUZoP+IQUcVz9Eiwe/tpvvKJMt1GF8lAbVXUoJ2mUp5TQlzczR/Qe3HtoQYNcg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792589043;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=4r0EtgcxqhaEJzKXt8BfJ00DyZK5tLzl31XFTzOS8Qw=;
 b=h1PhOsl3cvKC5HhYjk09nlXW0ZIZPMktZdypxALqSGtIoWhjAfvtbnNY11P3i8eel3YS
 +PQr+0QjzioGWbXi+SejDpdH14MUANpAfVk6/DYN8l4rgrgOagMJsmBzE5NxrRHtruW+q
 SXD+8Tn4RdVjXvGCGwGPiY+bJ/rffrN/h+FS1Q7C1zxFxMM8STBVXabLIRvJx1jz3SXov
 LUFxzDENIuyBcfXLiK49cPLXV5yw2caX54b2ZE8LM6sEpk8QqpIdI9QcZbXOM5RuWVNzS
 X2/bSfkqIR0R0V3omLG+wup3ilz2OKVUkfziHRaNhFbh7QX8atgRlbjsg17mH3orFWA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qJriUZOy; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=lucienzx159@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qJriUZOy
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDA9D4069F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:24:02 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-35f1f76ea84so1017566eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792589041; x=1793193841;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4r0EtgcxqhaEJzKXt8BfJ00DyZK5tLzl31XFTzOS8Qw=;
 b=qJriUZOyymlCC+ck5vWS+3+Jso5toyU+GuuFNdtzAC8KM/huBvuu/eEwXw23Xh/Fyv
 6iShMuRNLYYKpFl3TNmtX1tS4mGJMbg8JQLCZL3CRhVbMJJcGcQoN1jyKn6/ZqLguBfR
 X9IyuAM0yl0cmTwR8/BxRmCpSnKZnzMInQsrzHyvbeinOB6YGpW1ehb9wsQrzPmQ4+lS
 JMaYMdsFTBHiZ1unF8BQS7OSTI2FyeNlJvKVxY/jDV5PQh6wcYnRhb3APsyuODmRtPjH
 oCkH3UlAnBEvOZsCt2yNMvPUmYb+kFcIgxXyyV+Eb4vuaAWJkUgEjzN/b/QXAu0+3N9v
 TYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792589041; x=1793193841;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4r0EtgcxqhaEJzKXt8BfJ00DyZK5tLzl31XFTzOS8Qw=;
 b=POeiaF2sFUxj4SKuBNnwyUR/YHbY+mGbGVqTtIe7e7d+vOkMUiGjLDRT+MJoPO0FAa
 sSwX8ugUzUFrcjSkmRTL59h1F3ant9Od6RTAyPWjoMJmf3wcaXC+Wv7UoTe6Gqe4A+It
 qqNnPBW5/BVX8lcJEA3zTeIFdvZU0+NrfIzNaSHilb1LvvDQ/TrFlsWMrJLfg8GKZoKy
 M4UDt7XYl8m+jgZJujcgEpHrayZMxUQb0Bese3K3nr+7ucT8Q2fmBZhEqO7F6crioG3T
 ygnd+ztyKLHLoHlHqtc1NBfbbTXN7WcIhpNV4sQwNc1IA2fVkAwKyeLG9VTchrT14CBe
 IO8w==
X-Forwarded-Encrypted: i=1;
 AKwUvByFtXWXOwnVUf5pRiicthaXe04zxWs5Lw9d9IMADrc2bV50Ss4SdPSdRKwOar3jRFtr8Z1VQB0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLFXnTZkyKwxY2pDX7ljUrKmKn/Qq8jpe8MZg6IFRCxPOv083la
 /bgdotfme8lHL4Wp6Q8Uslz5hAKa3nB6fG6zOqXen7Y+pr52xt0qB3cf
X-Gm-Gg: AYBFou0xMaKZWJ6gLNTcAMWyMIvx+O5CXbVXoQHe7tr+Ps1MxxeYtCFAs6UTjM3Mfp6
 bNcda39QEPmhfct12R0Hf0RqkjAfbyvmaxCBH8DuWmOdivIsbGXum/wfrz3oClPFbHnNM0QpaX0
 mVLQvZJS6ti0P2xzOlvxEF0anbLqxeCB9Qom+t77MhdjkuMxFrZpoFJ0YA13TSynxDuugXtEd5Z
 smEFMjUgQpSSEMIxl6KX3suE25jK0UhKtSCXy/09lkChkogz7hjJSOR6EDoEA5rhT9e9QWM/RXP
 zjrA8Q2YkQETBEJFETtzcVec19ATo/PekoNuKZxFILwUOvrc30M5EIlTUovL8Pp7Zhp64RCHuSH
 ApJDDUDBvqe9aFCEtXSl+A1E1/ZtXh/ASkl+BTlpYaIL69tlNv5CT8Oh6pbxldxOdn2U9EclWC9
 PGqRh7FP/IhgFLrKkXyMp0jNDNCDF4KfPRGXxU+qPaCYtcViE3/LjarJF6obCsBvr+Kf0shTkvl
 0ih/PElegv3x/QR5WSfZVNgvSMr1izgzG+ucaHdfaKnxUwNvseHkajF3f8Ogb+FPkaYMBPiWm8h
 8P2objhlLa1Rwet9XYEm2Uxz1D42qiCogeHjnnC3
X-Received: by 2002:a05:7300:f408:b0:368:40c6:3a01 with SMTP id
 5a478bee46e88-36840c63c0emr485834eec.2.1792589041220; 
 Wed, 21 Oct 2026 06:24:01 -0700 (PDT)
Received: from [192.168.0.3] (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36741e71eaesm16202309eec.26.2026.10.21.06.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 06:24:00 -0700 (PDT)
Message-ID: <1f1a3868-0fde-49e0-b384-b2652cf0c959@gmail.com>
Date: Wed, 21 Oct 2026 21:23:56 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] clk: mediatek: mt7986: drop duplicate dt-bindings
 header
To: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org,
 trini@konsulko.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com
Cc: frank-w@public-files.de, daniel@makrotopia.org
References: <20261012162656.6918-1-lucienzx159@gmail.com>
 <30ad0f93-a971-4acc-9c5a-cdac831b3fcf@baylibre.com>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <30ad0f93-a971-4acc-9c5a-cdac831b3fcf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 14:48:16 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David

David Lechner 於 2026/10/13 上午 05:20 寫道:
> On 10/12/26 11:26 AM, Lucien.Jheng wrote:
>> From: "Lucien Jheng" <lucienzx159@gmail.com>
>>
>> include/dt-bindings/clock/mt7986-clk.h duplicates the binding header
>> that is already provided by dts/upstream/include/. Since the U-Boot
>> include/ directory precedes dts/upstream/include/ in UBOOTINCLUDE, the
>> local copy shadows the upstream one regardless of CONFIG_OF_UPSTREAM.
>>
> Nice cleanup, thanks.
>
>> @@ -526,7 +526,7 @@ static const struct mtk_gate infracfg_gates[] = {
>>   static const struct mtk_clk_tree mt7986_fixed_pll_clk_tree = {
>>   	.ext_clk_rates = ext_clock_rates,
>>   	.num_ext_clks = ARRAY_SIZE(ext_clock_rates),
>> -	.fdivs_offs = CLK_APMIXED_NR_CLK,
>> +	.fdivs_offs = ARRAY_SIZE(fixed_pll_clks),
> I noticed this is actually no longer needed and we have the same thing in a
> couple of other files. So I sent out [1] to take care of that. So I will
> apply 1 first and then this patch so that this line change goes away (after
> the customary 2 week review period).

I'll update the patch once your commit is merged into U-Boot.

Thanks

>
> [1]: https://lore.kernel.org/u-boot/20261012-clk-mediatek-apmixed-fdivs-offs-v1-1-f366cc5dd0d7@baylibre.com/
>
>>   	.fclks = fixed_pll_clks,
>>   	.num_fclks = ARRAY_SIZE(fixed_pll_clks),
>>   	.flags = CLK_PARENT_APMIXED,
