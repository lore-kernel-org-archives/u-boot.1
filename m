Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AC4CC6B2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A71FF607EF;
	Wed, 14 Oct 2026 12:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GyQ6AOWFBqXp; Wed, 14 Oct 2026 12:20:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1251607A9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980416;
	b=g+FwzloEKZxuBkhu8Nh+dg4Gklb6YSWiBnQbCfpw5R68f2R7Poy7XCsBjU5F5xIh0SaK
	 EJf31fHn4hW61OnCV2MoiTF78QIHfYx0yNJuKQPdQsTeoLYACHjSg2e8xDDbuLuSpArHU
	 UWXgBeU9V0Ls/4JFjnZkYNqDiCLUdqoktYUz9LIlv1z3CXhJUPxyvu9Kgngs4C0VckgyK
	 eZ2j2gDwWJoRBxu+sU+WWozjkW2zo3DZiqofLGyB6+2eTZriqnwWAjAShfXLUQzGZbVlI
	 dIrPkTKoevBseAX3eFK9ftMXr0EGsL0R2Co+2EI1fUqQA6WwqLFN7Bw2rV7p7tdYg0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=2BghMylJNeisVshKfw3QM75rV/igxY6EQ/9iYBeTVm4=;
	b=KTapXYgNahPhKzFRKj/rMxoKjHjbCKyL7eTAelsUyHNUD++Tm/B+el1nzHTxusGr/9Gv
	 egSmpGz79C/6cIzTj21fF97fgRd5vWcVvjt4suyOc5xXc/V6P/23Mq7gzQYr+8XsyYdLW
	 0QtxfAt50O8aG3L0j7FF2o/80AWhy6qYEP7bxIuBfltc4bR582UL8Jr7CXGNbFYePsdlm
	 GE86d65pwlhNnGfKIkHVkTDk432a1LaTryr0p16wjchUSIBdc6ls//rLHwlyi4eF5qv7u
	 vOj6CWZy1bbTmp9vNop5yXvU8FvgYKKW5KnhiNjRoIqUM1NKmjWXIVl7QzxL552LyVw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980416;
	bh=2BghMylJNeisVshKfw3QM75rV/igxY6EQ/9iYBeTVm4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xnl+S3ZxETbRdj5bAaoFwa389lht1wvSg+z67RPwDVpH+LNTWVHyFbg1C1mdg4x7e
	 xM+zijhsVgo5XJFJWJZg1eMfSG64+zQDw8YUKRXIIlCsBNK3dJmi/kDMEHWDjZTFMx
	 3IBI17rbIM0Lg1B7Z5G9GbdlFwWf4Tv5MvDJ0+/AHQbcZ73aGBLDOYnMGr9n9WUjT9
	 x6z6aQhp1iu2shYKsfE++1X0hwegN6y5BvQsRccrPmNEUpIBHpBpLmNHrtGZEQHYRv
	 4W6JBuZJSUEzicNTd4ZSuqmMChaKhOzW5iE5jIAbruNq4s0QrDOZ0IUNGZ8DVPkzyh
	 skaFLv06HSRSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1251607A9;
	Wed, 14 Oct 2026 12:20:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 649612A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A50E405E3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:20:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ss0d1j3NP6zP for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:20:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1327D403F8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980413;
 b=FBb2vx5SG33PNaqwkhtCTLdnDAWUSrrwDJOU+BiJsDN/wlZwMJCWA/GEf2n+ARA3nbM4
 cXbiyEiKtxEQaUOimvMnlvxsS6RP8ts3p8dra6Pi9WTXhLaWgY37dYkMVV0K86G0y/Rg+
 +AVcGTWLGaE5KgKQsFmGCSJR5g7u5ujZ0B/IAqu1Jg6vuTy5NOGYDKyrGb8OtX7Zbe1BT
 A+eRRYfFsc2ywuVkgaQL/TeYewD1luSYSIfzatU9TH9GQ9rjgfyAOntOkf/45AoLi/jre
 Z6oXML5Pd2dRTB7/NCSZYzi32wJoN13e4vHfupe8ArOwz3dxgCgAxEuRCyx8Lg+9e/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980413;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:References:
 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=2BghMylJNeisVshKfw3QM75rV/igxY6EQ/9iYBeTVm4=;
 b=HIDDbOwrZ5mYPVCvD5fUkqKKFuBG7nPbm3VjkE2Ou4pwyJZonmd4u+6JrsNBIvIRS3Yk
 /bI9CRdWY/w62ve7SZGVAWKpWXWz8r73DSKmuKnFSeZDV2MZlM82NHJElvzVJXkc6ffEG
 GId5AkS1kLys3DCrn49Bc+UYkoQeQpJRQXzfbjUbXpf/30LOe6alA4UR9tdjxeQtMP6Xc
 lW4nxGULQOug6rEK/hEJSo3qvby7PxDXmq3aaU/maxtTVv8c7foIt6B03elvNLC7b/SwU
 mYWVibzLTlA7dhK2sBbEv3DfpN8oO4fkWe25dHCnjm5+nMuHIXAEHY10JbCxPcPHipA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=phmD2AB4; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=phmD2AB4
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1327D403F8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:20:12 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so33366945e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791980410; x=1792585210;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2BghMylJNeisVshKfw3QM75rV/igxY6EQ/9iYBeTVm4=;
 b=phmD2AB4xPj8565+e9UKsR84IRYU9jHkaiik/oz5AYgE8q7gSjzCdQ3FjLQRxYOmcs
 Vd/Ih+uO70tUDAjVcoTQDy0t/fkvw9z6yoF9tN9yTkYGRR4b6YwvA+O7wqI/RKc22Pt/
 wtUqDxeHgGurNPXhERylRBirDdrvijLgT8FcQNrk9PJGhC++PQKnIRVE46ZPZomdwAxf
 8V4Oh75DahuLB6cgVAyxRWLtzJ+CHAAo1bgqa6pLI9Th4rdg0zjMJyyKvwQ+OdYrbk4T
 7fYwtMSCU2nhqRqCyrgvHAUxFTGEmGe4kIfQ/zRgT++tNQuhkwiA6zr1wjPfREUu9UBW
 ozAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980410; x=1792585210;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2BghMylJNeisVshKfw3QM75rV/igxY6EQ/9iYBeTVm4=;
 b=QSKMfLdIvioySpVbnDnbdN/Mb31V5EzZ/nKnvTMiZvvZRfhhfRt2ekmNYja8JYO2eh
 uUscrizTnxg0UTdwNWv5g2rxDfeWchyOWfkshXJ/bik1+xyhumznrNWiLsWPfBUbiOmB
 sZLbf+GCprT0zlCW+eCRtAbJLHhGNsmqtCRp8VlvuU16bTSFUlk96D/xbsZHOJI07ECK
 6Wgv8ShsPECEXhvf30Ya2b7iZqwXEnrFAL3HNpU/VFKtzw6rMycjm3dTsTKZr5yYGK/8
 706kzx/5OhKDV3IAJffEe7BpemAYkBprPzm0RaiIpTwC0bBjuDkdjPD7migDNJQO0rOQ
 up2w==
X-Gm-Message-State: AFq9FYJe7djRj+eAJs1O29xHELZOUCHJvmNn77vHBI0VYfT2SYxkauv6
 lnE9fFR9vbC5/SCE6wv/o3GlgPPNnNfCLrAWB9yErBFLausLD1MvR59up/1v3iXB5Oc=
X-Gm-Gg: AYBFou26W/5kG04veQgmS10jXBYyclvtpZsw+c3LdcmX2IqlFdRiGWjSGLw6B3lUbYI
 3y1S6OrMt8Nz2qvS5bVUGic2mpK3JjiAxzY2lTSo5MyBJBJDzuaOmRvPr9R7t1whMwalKKJJ+gT
 2NaWEXbvsba2tI57tZeQR6w/ddqGJ7kg5Qt7cJlxEknJz6BjG627QBlLvkcT5TIbaw1rIpEwXjj
 KQqyIg4MUxK5E2lr7WEHyx4mAL+9dEYQ8j16IW4jHt9Op4B7e+z08bloU+HgN16TWZv5sQPLIF5
 1upCHnKJfagc1ABrym4erxPQjiDsa9uym0ITVP24JsA21rK+pP7yLZs0w8izlWGsy4SlEiYtsjj
 GO9gRSdGsPOlt8X8CrqvNim+6ikfxAXFiTv8aJUzSa+0Oj47w5CkVkeirT3LczRw5iDmVm+Q0fT
 ywwfuDI97OmZzL+DTTUbCTfPQBFteoSjC98C7uiQxv8/SEdXvcxR83KuVutC0zDJpGYpdhr5mHp
 g51n8EEH2zZf8ubpY87Y6Jhk3D9CD2CWSivaVFxMtUCI22JonlR2Uk=
X-Received: by 2002:a05:600c:8518:b0:49f:cbf3:551c with SMTP id
 5b1f17b1804b1-4a18e4a8ca6mr283106715e9.12.1791980409036; 
 Wed, 14 Oct 2026 05:20:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4?
 ([2a01:e0a:106d:1080:fdbf:f373:6d5b:93e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18beacd2csm482489035e9.14.2026.10.14.05.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 05:20:08 -0700 (PDT)
Message-ID: <bb2b9013-2499-48ed-a8e3-a903b5ab8dc1@linaro.org>
Date: Wed, 14 Oct 2026 14:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 1/6] ufs: decode string descriptors as UTF-16 big-endian
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 dlechner@baylibre.com, trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 tanmay.kathpalia@altera.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 xypron.glpk@gmx.de, s-vadapalli@ti.com, michal.simek@amd.com,
 jbx6244@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@oss.qualcomm.com, jens.wiklander@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org
References: <20260918200641.2286077-1-jorge.ramirez@oss.qualcomm.com>
 <20260918200641.2286077-2-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260918200641.2286077-2-jorge.ramirez@oss.qualcomm.com>
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

On 9/18/26 22:06, Jorge Ramirez-Ortiz wrote:
> UFS string descriptors are UTF-16 big-endian (JESD220), but
> ufshcd_read_string_desc() decoded them as host-endian and so left
> dev_desc->model blank.
> 
> Give utf16_to_utf8() the source byte order and decode UFS descriptors as
> big-endian, matching the kernel's utf16s_to_utf8s(). The EFI file-path
> callers consume little-endian UEFI strings and are marked accordingly.
> 
> Fixes: 067c1b033282 ("ufs: Call ufs_scsi_bind() from uclass .post_bind")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/ufs/ufs-uclass.c  |  7 ++++---
>   include/charset.h         | 17 ++++++++++++++++-
>   lib/charset.c             | 15 ++++++++++++++-
>   lib/efi_loader/efi_file.c |  4 ++--
>   4 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 6ef01f8e4aa..21aed9f97bd 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1767,11 +1767,12 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
>   		}
>   
>   		/*
> -		 * the descriptor contains string in UTF16 format
> -		 * we need to convert to utf-8 so it can be displayed
> +		 * the descriptor contains a big-endian UTF-16 string, convert
> +		 * it to utf-8 so it can be displayed
>   		 */
>   		utf16_to_utf8(buff_ascii,
> -			      (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], ascii_len);
> +			      (uint16_t *)&buf[QUERY_DESC_HDR_SIZE], ascii_len,
> +			      UTF16_BIG_ENDIAN);
>   
>   		/* replace non-printable or non-ASCII characters with spaces */
>   		for (i = 0; i < ascii_len; i++)
> diff --git a/include/charset.h b/include/charset.h
> index 348bad5883a..79d0ae1ef49 100644
> --- a/include/charset.h
> +++ b/include/charset.h
> @@ -13,6 +13,19 @@
>   
>   #define MAX_UTF8_PER_UTF16 3
>   
> +/**
> + * enum utf16_endian - byte order of a UTF-16 string
> + *
> + * @UTF16_HOST_ENDIAN:	code units are in host byte order
> + * @UTF16_LITTLE_ENDIAN:	code units are little-endian
> + * @UTF16_BIG_ENDIAN:	code units are big-endian
> + */
> +enum utf16_endian {
> +	UTF16_HOST_ENDIAN,
> +	UTF16_LITTLE_ENDIAN,
> +	UTF16_BIG_ENDIAN,
> +};
> +
>   /*
>    * codepage_437 - Unicode to codepage 437 translation table
>    */
> @@ -299,9 +312,11 @@ size_t u16_strlcat(u16 *dest, const u16 *src, size_t count);
>    * @dest:	the destination buffer to write the utf8 characters
>    * @src:	the source utf16 string
>    * @size:	the number of utf16 characters to convert
> + * @endian:	byte order of the code units in 'src'
>    * Return:	the pointer to the first unwritten byte in 'dest'
>    */
> -uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size);
> +u8 *utf16_to_utf8(u8 *dest, const u16 *src, size_t size,
> +		  enum utf16_endian endian);
>   
>   /**
>    * utf_to_cp() - translate Unicode code point to 8bit codepage
> diff --git a/lib/charset.c b/lib/charset.c
> index 182c92a50c4..8ccac4048c0 100644
> --- a/lib/charset.c
> +++ b/lib/charset.c
> @@ -5,6 +5,7 @@
>    *  Copyright (c) 2017 Rob Clark
>    */
>   
> +#include <asm/byteorder.h>
>   #include <charset.h>
>   #include <capitalization.h>
>   #include <cp437.h>
> @@ -458,13 +459,25 @@ size_t u16_strlcat(u16 *dest, const u16 *src, size_t count)
>   }
>   
>   /* Convert UTF-16 to UTF-8.  */
> -uint8_t *utf16_to_utf8(uint8_t *dest, const uint16_t *src, size_t size)
> +u8 *utf16_to_utf8(u8 *dest, const u16 *src, size_t size,
> +		  enum utf16_endian endian)
>   {
>   	uint32_t code_high = 0;
>   
>   	while (size--) {
>   		uint32_t code = *src++;
>   
> +		switch (endian) {
> +		case UTF16_LITTLE_ENDIAN:
> +			code = le16_to_cpu(code);
> +			break;
> +		case UTF16_BIG_ENDIAN:
> +			code = be16_to_cpu(code);
> +			break;
> +		case UTF16_HOST_ENDIAN:
> +			break;
> +		}
> +
>   		if (code_high) {
>   			if (code >= 0xDC00 && code <= 0xDFFF) {
>   				/* Surrogate pair.  */
> diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
> index 19b43c4a625..7dee57d594a 100644
> --- a/lib/efi_loader/efi_file.c
> +++ b/lib/efi_loader/efi_file.c
> @@ -184,7 +184,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
>   	int flen = 0;
>   
>   	if (file_name) {
> -		utf16_to_utf8((u8 *)f0, file_name, 1);
> +		utf16_to_utf8((u8 *)f0, file_name, 1, UTF16_LITTLE_ENDIAN);
>   		flen = u16_strlen(file_name);
>   	}
>   
> @@ -216,7 +216,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
>   			*p++ = '/';
>   		}
>   
> -		utf16_to_utf8((u8 *)p, file_name, flen);
> +		utf16_to_utf8((u8 *)p, file_name, flen, UTF16_LITTLE_ENDIAN);
>   
>   		if (sanitize_path(fh->path))
>   			goto error;
> 
> base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
