Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F4606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 21:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iXg2gWwS;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EuDc1TG+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8A1280CEA;
	Tue, 20 Oct 2026 21:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IdwASJgm_Lca; Tue, 20 Oct 2026 21:36:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F39D180D59
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792532209;
	b=GugYwbOPB9qivGRqtjjgWMKOj8n2VzNZ6NvlV+wDZkewGmavifoEigl5t28pqm54tUac
	 quJQ7H8KVbFN5BNxgyylSqwDU/bHMCtmNVwcf/XmRyqjz3zpd+53J/tEYFY7OlY8gTOQJ
	 ZLG6mqjWCEF7vLNIu79USJ6TcTaudl+eEfwawiaoNU4MC5rQoTmfkM45R5wi0hcNS+R/d
	 74Wo3cm+AyKGRHscl9IPbqRtUJq0DLmpcGotzZz6PLfdszZOvgvu4TfQsGPWWPhHGGi+k
	 PF9zSd3kue1Jq6gCo/5DVh1S2r8+lCYVNtJ4PbczmXF1b/5cuXR2crTikfUuBm5BBwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792532209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FScjDT2kpfrwtO2RsxreRTMqP4teiIQ3X1cjB8+9zdU=;
	b=h6lQ0GaStqO2BKtAoi5vExoqAuPsaZLEMZq/hawNACzjhn8+PRRZI2rPNwCsOj7233Sh
	 wQwOL4fd80S3ZT+T+JutQJroME6w1BA924dZYsAwOnmtaDzNJer9JixOyw1SAm+Ec/xcS
	 10Vm5CMYfc97nhZoOFf9wcmk1agIMkEOYCCAya/iPQ2wpStS8nY99+CKwq2n8C0uFUPvE
	 jdzhZGTNqiRegcO+aYoJfvhM5RH/TJDWmoz4+hFDxjKIB5CHAv+WfoQFTnrwfohBjXSwY
	 o1rAJSqT/A2DZ4ELDaOHUt8WCmjqhw+pJFf7Oj1jlqEpEmw4tPF4lL4aByextxUGmUg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792532209;
	bh=FScjDT2kpfrwtO2RsxreRTMqP4teiIQ3X1cjB8+9zdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iXg2gWwSsLGWk4JL8zLkoURAPt+IFSW3BWDMgoNjla6LM5X4MXHCpQS6lZV6Ctxo1
	 ljMNHFlwU8chik0gi8YtFxXRmBMI61WmvEtGbTAe2svmOnMcRadGF+AfvwkYDDXcdb
	 pS4NS/MifpD3Tild8xuKLyszDMqkodKhysqhuCRKCnOER/mv0MCYVYFYhJIeqXRbcy
	 OD/k3rYPPWMEqw2OtJCHt2nj0/YfQj3sU1nebGUiircyc2RBb1xGvCwXAoplOod/jC
	 Q9/A2EoWkmIk4DbKwnrR1bgv+ofnli8fKyBdiQEidL+4z2iM/auyGn2HMWpiQnhL8P
	 f4w+MgRgbqWgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F39D180D59;
	Tue, 20 Oct 2026 21:36:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3EB7380
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F161F40112
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:36:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0sCJrzlnkADS for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 21:36:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ACB174005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792532206;
 b=WrKB2T4hY/NDkEVyhzfYiXAUyvQYxD+lnnthXLQSL4wWPCx8DBOs36ITyfaLrrk6f2wQ
 TKfvPtWVmDQdzXKg7X55hfr+dxJbS2IjFLOahQGzs7yhfkGNpOl9fzkXe1sq0vA7vrIXD
 jq7IqNfAL9bt3xMXjRy6Un1y92WnqKaQ4x3zBk5ol5xsPRTFkG66QpWsfFwCzwHrT7/W1
 dfbBw2dkP87ZiugdASJeTONzuucsSELPQYM8TKJZ/y1agm/0RDZvatWM8Vqz9XH5ymcYo
 1UydGPwZmZPa/KH3Dj+hTaaHCa6R5NoFSClo1G45HvQkk/t/1hXhbCROUEKKMh3y5RA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792532206;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=FScjDT2kpfrwtO2RsxreRTMqP4teiIQ3X1cjB8+9zdU=;
 b=iSrrE16dhAvZlWh7uK78h+wFyZnxYqJumc1VNLzjNSDNwdf5viTeR644AmuIMH2SQ+ex
 OA2OjDNSJYnQrVHcSkyd9d5A3yuBYIaP02w1PLldyZDVWyiLajt8urRxwNmsqeS6c3F4r
 tDqrN/r0WD9HQF450rEgWckqYAiJLqMmULVlsFNXUijY1An1tLv0RWB6ySyQMwNVN7jyH
 aXU019+fBZyzj+2huYkzB9XoIiXcY4FdWsAKGqI/4ki2m55x1H8TdBOC94kU3bbiyepfb
 hMrvqmPZXSw7DgWzX0dEEa11L5PseC4dWFMKr95CRxTv1cw0iZ5DZAwgrb5YlQEXU4A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EuDc1TG+; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EuDc1TG+
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ACB174005E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:36:44 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-490d838b425so74173fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792532203; x=1793137003;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FScjDT2kpfrwtO2RsxreRTMqP4teiIQ3X1cjB8+9zdU=;
 b=EuDc1TG+XfzBN+1gNa9T0RnMIL6qeZQJxmFIfd+djZaUcpijdQJ+Y46D1QcXWpkmxO
 R97RldjhWmzAOcNTJCb0pBnSGX4d8n015L2hmAXBtQqh0C9UA3fHLiZAdHXewG0e/wUC
 xDoEhZRhfzi9dpofFfeL7fpQJyvCrqqOqgtuYZzzVy2XH2NiZIwKJbIWN4ja5lWww3CC
 nbN2uz3D5wfyMuffFHPFyYhWF0voztbi4LtWxaTMwh1JZgkg9kJEdG1TWG/xZaFe6hDx
 axrE9XZp5SPGTeoBfXI2u6clj+Of/FL/3GfRNdBHWTvCi/w8+L6lSsjeJ5lgKSynPnic
 xZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792532203; x=1793137003;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FScjDT2kpfrwtO2RsxreRTMqP4teiIQ3X1cjB8+9zdU=;
 b=cOvA7+YaImbIsDCWC9ZlFnpbmAc++dKAvVlmQTfcUOxUrcVZrButQbQOJOs5rhrAyS
 M2uh2nHQFTUbFPziln3fbpdhC4gJ7z25P7UDdXIJR+JD6Walh7N0ZmryUvzUb1fmphFz
 cuLTmnnnZXUGeuohNtvX2Gs0vS4VYMO+OfREVx7LaTA/k2WDbaV/1YdTVeywRfDjGBOM
 iCZ/Kr1PkEpIJNMILZCGGcxmS7pAe84tHaHCgKzrpRtamMyf0zZUyOFS5rOLcoD6HrZ5
 6XJm/7EzvgavwlMzy/F3N66jsiLI9obIbr1IrABYokKYurvBOuzApv6C9zk5rrmvOb0m
 4RlA==
X-Forwarded-Encrypted: i=1;
 AKwUvByXFMQcbakhyfnHehOxJ3hl3LlXjSni5nnLQyJmR4YVWGRbaZICwAkCCygQVz4QpBwVpFKwwsQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK+TL7j4ICZe+zX7zUqFAdPok8FrqXulUMCF9nY+tTVT0pLkxHA
 VEVbbiPG1gKM/LIsfSjaVtx6/bl1nZWJvzgQ40OZi5UXJO2j+jNvBgUFMIBOK+nMRtU=
X-Gm-Gg: AYBFou1Qd48AxhO9jQRKdRYyCZCxGKNahQCOVI+aDr6itUSAROb/tSBPf5xkWCNL91Q
 PnkDdYfaejze91M/O8FakqYb8pRwEvKQtFgm/1JiWbDjXVzxtpnBCyE/rXD/Y947X9hNViJ4i90
 P8omZpSlvuOKccTo1cQchKA3Nmh9igdUMo8kWmo4ByCABJj1X43t3q5sVlqc7r70wV/GQZdYo2f
 bjYlI3sNdSidCcFfRRcOny8TQKVTuPsqVF5JmnCGxDKbDWjnkf8yOq/PKPfHMiF2ReCBHnnM0i6
 ywuPgkKITZihe1J8ua3rxMh1w3vNOGrAt2+oSLi97T4DEy1K3ei9mt8DsoGwZ7IT6cwsvejsEb8
 tSY5HuinooEKQ7af/paCryBMp3RhwDNFLfJYpEaprq3FeeJKq/UG6V/9j1wWtIQltavc5ZCYD/y
 P0cFeB5PiUKvF4Sx7S7LTkHJhZtDN1z8HRqYsoHmnMQZ4l/XGc9Y8Vsv0lwrzzthS0c9hMOoAfH
 X8GS9wMLpFD3six+TNvXhDZIqg1Q70tknjHcFbDI4i8AJJBR2Ay8nZDQhOUwbtRa6GSSFovbf01
 wzrHOfi3jn7VJkqBsGcGlD/DcxXdpQ==
X-Received: by 2002:a05:6870:b3f6:b0:475:a1ec:961e with SMTP id
 586e51a60fabf-4a7579a5275mr10282456fac.32.1792532203307; 
 Tue, 20 Oct 2026 14:36:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a238:1d98:cbad:952a?
 ([2600:8803:e7e4:500:a238:1d98:cbad:952a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a7d61ce790sm528498fac.11.2026.10.20.14.36.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 14:36:42 -0700 (PDT)
Message-ID: <afdb50a6-c848-4e7f-a163-cffc3a821494@baylibre.com>
Date: Tue, 20 Oct 2026 16:36:40 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] arm: mediatek: enable SPL fastboot DAs on Genio
 510 and 700
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Julien Masson
 <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>
References: <20261006-ccaione-upstream-mt8390-da-v4-0-63d7d124780f@baylibre.com>
 <20261006-ccaione-upstream-mt8390-da-v4-2-63d7d124780f@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261006-ccaione-upstream-mt8390-da-v4-2-63d7d124780f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/6/26 10:01 AM, Carlo Caione wrote:
> From: Julien Masson <jmasson@baylibre.com>
> 
> Genio 510 and 700 need a way to provision blank eMMC and recover from
> unusable boot firmware without relying on the installed bootloader. Add
> a BootROM-loaded fastboot agent that also prepares the eMMC boot
> settings so newly flashed firmware can boot.
> 

...

> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index 35f748a70d6..e052fbda73e 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -4,6 +4,9 @@ obj-$(CONFIG_ARM64) += armv8-mem-map.o
>  obj-y	+= cpu.o
>  obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
>  obj-$(CONFIG_XPL_BUILD)	+= spl.o
> +ifdef CONFIG_XPL_BUILD
> +obj-$(CONFIG_SPL_MTK_BROM_DOWNLOAD_AGENT_FASTBOOT)	+= download_agent.o
> +endif

Could we avoid changing this in the next patch by making it

obj-$(CONFIG_$(PHASE_)MTK_BROM_DOWNLOAD_AGENT_FASTBOOT) += download_agent.o

in this patch?

>  
>  obj-$(CONFIG_TARGET_MT7622) += mt7622/
>  obj-$(CONFIG_TARGET_MT7623) += mt7623/
