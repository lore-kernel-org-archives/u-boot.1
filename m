Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D29C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 08:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451D082D06;
	Tue, 29 Jul 2025 10:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vh1Lbzsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B5682F00; Tue, 29 Jul 2025 10:25:46 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A8C82C87
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 10:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-455b002833bso20082065e9.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753777544; x=1754382344; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=uRPOgENsCUYwosfY8rkvj7KplNFpHu9Aqo4/4bd2mN8=;
 b=vh1LbzsizngrUXTpO4wWCD+Sl+RGC2NzsH/NBrlSj8MPszPAEwF9+5E+YT33+XhPHM
 jhLxI04hf/ysBOC371VoeGrtRQ5rTZzZH9prhoqVLGouhhLqrlBSawBxCekj8QIKZBtQ
 t+12FpeHWxxBlkt3Da72S4SgAo7oUz+J2Kqy/D2Df5KhYm+OcPK37nbVHdY17xRGLuDu
 /r08JV62+TsE4aU+tvo5wJTBogW8auk7AbtTjsVx1qRCkkmPp3bNrGnbL8JvQCWSIiec
 pt+V8WzkQKOnpTSppgdGNCDTxpLjpiTKedOhnS3rcnFas4aPdluDZeBCikyMTelYgIi4
 5BpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753777544; x=1754382344;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uRPOgENsCUYwosfY8rkvj7KplNFpHu9Aqo4/4bd2mN8=;
 b=Q1oc0dmmLzwTIz/MOr34XlH+7TEbS6ueUq13pci4mbbdIYcU+ZLdNyRUvfwEdSh86m
 O67Mh7m2aWg9w1ehS5o/u4HkRoiJ3bjMnRbRFc1i3Q6T/3SRGvU6r30Jx1M9HcpU8qbR
 h4s9sRcrfZedu7VE6I+mTSNc2B1+T63zfdrQvW6LeXunfKBsHyf3WqjVEyY9bxV/Gfsp
 E9UrSxVrTdflKvent9GcPW5G7qviEuEhImF5ogbmTSH3LXGO0Ks4xljUCBg4MOLxZ9LS
 9q4Hnp4KhcG9KGC840JxJ+UQ+LBmCIXjkd3EtivIW/mF1VcwBS9wXt2s1EyXyxbTeqBV
 zkMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmkWDk5yHmyzsK0NfFT2LzpEYLZxg2FDZBPk2y/lSyyKMp9sPyDoyI2wH2zM2tnrEvHkBSm38=@lists.denx.de
X-Gm-Message-State: AOJu0YwQ37PbayF0JmXJLEhx//D7Env6JN/q7ZVuReGaPy2pdCfuXDkB
 z3EBwSsR+TqJSI9XyIMRD4OBKzz2Fk1+Vsll4lkYG1xTqpv7/oqDMzba2CUviR28Trkv1CoAQH5
 9cBsH
X-Gm-Gg: ASbGncts+XaiSPy2XV47Ur0J5U6sCqy1UXIQqh7fkaLK2iEul3el/kZi3mnW+IT/JLn
 b1PlIyaoqePhv3w8oqUmG9Ow8MAyYtYUTifhL2orciRy3+6RTdyr3z3X6n0pGKMhyOaLXGoZsyD
 J5NGvJTVFcpgKE9xW3HFQsHQ/HAABTNUg17hExo+FdsbTxeiUV4deuMaGOidchvw9/af8wvpAyI
 0CZY+tu3IQHrRes3rGVOM0qD5VWxofEDibirhh34UKBnyDVvCWNjvhzGBMFCIux8ZppDVF5biE3
 gQg0Ot4R1/TTSEnlqosh3e3KKfIbGHmFmbRo1z4ryxXSCnlt6ozRDhU3z9Tm7P2L8SX3wUf8epP
 0dBIsrxjq/vpClMcBZXMW2KelZZDJzsUYdIevTYq6mbe3yFdkBINnDp+VX0YVYQWARhfwI4Jx
X-Google-Smtp-Source: AGHT+IEBF/an0iFrzaoGR4n9rgcEmcb6m1Jh6EgNdeCylCMjrfSrBCMOmh3vti4Sd/PAhKGKgZX0cQ==
X-Received: by 2002:a05:600c:810c:b0:442:f97f:8174 with SMTP id
 5b1f17b1804b1-458765475bcmr128129765e9.18.1753777543761; 
 Tue, 29 Jul 2025 01:25:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3ae8:20b:c783:9328?
 ([2a01:e0a:3d9:2080:3ae8:20b:c783:9328])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5b7677sm14133665e9.7.2025.07.29.01.25.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 01:25:43 -0700 (PDT)
Message-ID: <26a8955c-5990-4cb4-a5c4-478a3a86f2b8@linaro.org>
Date: Tue, 29 Jul 2025 10:25:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] drivers: scsi: fix inaccurate block count reporting in
 scsi operations
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, quic_varada@quicinc.com, casey.connolly@linaro.org,
 andrew.goodbody@linaro.org, lehmanju@devpi.de, u-boot@lists.denx.de
References: <20250728162105.63429-1-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20250728162105.63429-1-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 28/07/2025 18:21, Balaji Selvanathan wrote:
> The 'blks' variable in scsi_read/write/erase functions is updated
> regardless of pass/fail of the scsi operation . If the scsi operation
> fails, 'blkcnt' is updated using an incorrect value of 'blks'. This
> wrong 'blkcnt' is returned to the caller and it assumes all blocks were
> processed correctly.
> 
> Fix this by updating the 'blks' variable only if the scsi operation
> succeeds.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/scsi/scsi.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 78efed6b66a..05608399be1 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -228,13 +228,11 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   			blocks = max_blks;
>   			scsi_setup_read_ext(pccb, start, blocks);
>   			start += max_blks;
> -			blks -= max_blks;
>   		} else {
>   			pccb->datalen = block_dev->blksz * blks;
>   			blocks = blks;
>   			scsi_setup_read_ext(pccb, start, blocks);
>   			start += blks;
> -			blks = 0;
>   		}
>   		debug("scsi_read_ext: startblk " LBAF
>   		      ", blccnt " LBAF " buffer %lX\n",
> @@ -244,6 +242,7 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   			blkcnt -= blks;
>   			break;
>   		}
> +		blks -= blocks;
>   		buf_addr += pccb->datalen;
>   	} while (blks != 0);
>   	debug("scsi_read_ext: end startblk " LBAF
> @@ -286,13 +285,11 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   			blocks = max_blks;
>   			scsi_setup_write_ext(pccb, start, blocks);
>   			start += max_blks;
> -			blks -= max_blks;
>   		} else {
>   			pccb->datalen = block_dev->blksz * blks;
>   			blocks = blks;
>   			scsi_setup_write_ext(pccb, start, blocks);
>   			start += blks;
> -			blks = 0;
>   		}
>   		debug("%s: startblk " LBAF ", blccnt " LBAF " buffer %lx\n",
>   		      __func__, start, blocks, buf_addr);
> @@ -301,6 +298,7 @@ static ulong scsi_write(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
>   			blkcnt -= blks;
>   			break;
>   		}
> +		blks -= blocks;
>   		buf_addr += pccb->datalen;
>   	} while (blks != 0);
>   
> @@ -322,7 +320,7 @@ static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
>   	struct blk_desc *block_dev = dev_get_uclass_plat(dev);
>   	struct udevice *bdev = dev->parent;
>   	struct scsi_plat *uc_plat = dev_get_uclass_plat(bdev);
> -	lbaint_t start, blks, max_blks;
> +	lbaint_t start, blks, max_blks, blocks;
>   	struct scsi_cmd *pccb = (struct scsi_cmd *)&tempccb;
>   
>   	/* Setup device */
> @@ -339,19 +337,20 @@ static ulong scsi_erase(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt)
>   	      __func__, block_dev->devnum, start, blks);
>   	do {
>   		if (blks > max_blks) {
> +			blocks = max_blks;
>   			scsi_setup_erase_ext(pccb, start, max_blks);
>   			start += max_blks;
> -			blks -= max_blks;
>   		} else {
> +			blocks = blks;
>   			scsi_setup_erase_ext(pccb, start, blks);
>   			start += blks;
> -			blks = 0;
>   		}
>   		if (scsi_exec(bdev, pccb)) {
>   			scsi_print_error(pccb);
>   			blkcnt -= blks;
>   			break;
>   		}
> +		blks -= blocks;
>   	} while (blks != 0);
>   	return blkcnt;
>   }

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
