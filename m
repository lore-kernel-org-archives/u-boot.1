Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC86E9A038
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 19:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6F483C32;
	Tue, 17 Feb 2026 20:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RaU5TvrK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fB1gaF+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7846483981; Tue, 17 Feb 2026 20:05:51 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8231083B99
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 20:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61HFU9tQ2319712
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 19:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 poIAiFI+EMcc4x3/jLfN996Ap1dpXOkq23nelXsdcnU=; b=RaU5TvrKe4P6+JsP
 +OXFJmPrqFeVao+8uLJCVTxFjkojE3dlV3HRIaqDRPQxLISGnQEhIX3b+TtdeAoZ
 UpBop4QVKBB2ZPBCZNI3FnbOQvytVpPeZhbNSnkY3grNXXmNPP9SNNVBvyvbMdpr
 dSOt2XjlylkWBKwz9sxQaLEEC8OfVDlnZnznErYPE+wwG8OE0tBWPLkMTIH+3xjK
 JIVzjbwFd5ppae8Py6be0j2ePY6VCJEtEV9nrh3jrlaLpYYgdVfsRk/PtChSC3WK
 qjbMlwZ67dWojeZ4I5SeAr01I9rJrX3WHlZKunh0jk2PtyuXg6hnJCgpzgUGOMNg
 OaYctg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccu1erqbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 19:05:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2a7701b6353so60857155ad.3
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771355146; x=1771959946; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=poIAiFI+EMcc4x3/jLfN996Ap1dpXOkq23nelXsdcnU=;
 b=fB1gaF+zYqcDuMi3TBGtwXlc6p1O34r41kfAhfP5gTkNQvLmGSatluXpM7+rrNjsJA
 qbT2TkBLBYuzs0BOEDL48DAQS23Jt0RfNKYdTBWNkeMuDcYwaPci6lghq9RSrwP+fmuj
 yMgSPr/We5fdnXVBIPEXikdyoy2dEI+mkdC0galknk49d6rHmvNcwpw/VG4kkmRHRfTe
 GHE//PMQpZ+vcOVhwVsgKnbkz3s9xS62PYmI9Bj3p552KnoZIAj5ySkcVXtlGL6+kvnv
 pV8Hq009/1g5I8OO1lqn4rgfEF+/rAYwwXv6c2TTfdB0t3TZnqbf5twVqV4Ru0n801YY
 oRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771355146; x=1771959946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=poIAiFI+EMcc4x3/jLfN996Ap1dpXOkq23nelXsdcnU=;
 b=n8vEeOw4338+KW6LTzeqrllw+s3jT+TSQK+nmUxaKeMTluDp4f4/Tw9TWp3RAG12Yb
 bWKIo1llY/c99l/McACKUeaY1NeLrhsEqBB4tZV5og8mKnhgmsG0Ixsqfk+O+AYTkio6
 PC54iyREV4HgKoHzi1OYNDMriDBpWXf+KsvMrn1A6ecIeYoNj23g+Rie6XxK2PBOkCaQ
 dcd9CIe7wFfEQp80UHXuZb+JFnBU0Xl3JviWEqAqkffQ0eCDK1VnfBg62WlYtta7jppP
 bmxDvnOSJABT6EDfRCpY+qu7WPyK49QEkBWULHjWgWt5ftAfZwzVRx05Qc7zEYzFJ+kr
 H4GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmfFe8eLkx2/UQp0nm+8EijwN79ZvgPICGPLojSpj+K58FmZi6jw6cNCJKLEnW+kEcNwRmxrs=@lists.denx.de
X-Gm-Message-State: AOJu0YzZlcUIDYdvNr9qAO9VDdAxjwLBpll6OAN9awHyacJw3NfssNx9
 upfFFykLj04G+ZxR8YlCELRvY/Y/kjmwCi8c+hi2ntPMwHAtK0PtmwKR/Z8e6ZB3PjHHPgV79bg
 +Yid5zL9mpQBJzVUO1qPCzEwbjcZf9/G7cCsmkoyQoPqX7F5WD8UdQmQW
X-Gm-Gg: AZuq6aLKbT48NxswxPNFxRtIz5jfjjgoMsMit7/UecNJoHDLc9vmX7O/D6z5oQ5+Jk5
 7gQLN8BLOKUduSjceobK5wd/YyEQyTwhHKBpeGZIjcxPMBxpnfSFr+pSF9XRqgLmhSiwhR6imQb
 rfu7TaZhrtWArsyThmdxMsAgKZIIdb2WX4aZnwaEmCELeTONP+8R0YyEwx3DUBDEGvtCLUAcds3
 ZpIeHTCzTIQMSAPRJcff48AnYQBVE7baCols5Ir8ZnAcRbSbSHIZPHQyfvPyi9+DAuwU0BCWL7g
 0qjnFZztP5Gi+BgtB/0crXpyCpakiZgXHiq+yv0EEKNO25W2audfSDRtNGO+vuC75/1v8M1lhcC
 HpMvuCTnV3tp6DxsJDelOqKSkHrXzc6/d+qTTKZ1hW8B7NPmdlnU+aA==
X-Received: by 2002:a17:90b:4b83:b0:356:8719:f5b8 with SMTP id
 98e67ed59e1d1-35844fc0929mr11072237a91.29.1771355145249; 
 Tue, 17 Feb 2026 11:05:45 -0800 (PST)
X-Received: by 2002:a17:90b:4b83:b0:356:8719:f5b8 with SMTP id
 98e67ed59e1d1-35844fc0929mr11072203a91.29.1771355144682; 
 Tue, 17 Feb 2026 11:05:44 -0800 (PST)
Received: from [192.168.1.10] ([223.178.81.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3567ebc34c4sm21083758a91.13.2026.02.17.11.05.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 11:05:44 -0800 (PST)
Message-ID: <497f7e07-3a5c-4a7a-b2bb-9016d6927ba4@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 00:35:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] misc: Add support for bit fields in NVMEM cells
To: Sean Anderson <seanga2@gmail.com>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de, sumit.garg@kernel.org,
 casey.connolly@linaro.org
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-3-aswin.murugan@oss.qualcomm.com>
 <3fe5e11d-7240-c577-64fc-062d5c5e4d6a@gmail.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <3fe5e11d-7240-c577-64fc-062d5c5e4d6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LfsxKzfi c=1 sm=1 tr=0 ts=6994bc0a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=8sQKdzLGWpe9X/dURiXpGA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iRf3lNkDPbpjM-yYXwwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 9ljf8u6Y7N1h7rbHDWeKzOMSp6ZqsUyK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1NiBTYWx0ZWRfXwcSJa5V8sftR
 7dkTDAMLBu+Q4z4a3JtDDFbHlotfPzDkmGHlpouLdVFtmrvomDUjNf0p/IFOCPBI5zlnf4ledET
 VQ7BAzE4P16SKcB/atm21avmxPLRwCliWqe4E9DbF6iQxet5OqM0T1ATJxCorkMvR+axcdEq0oI
 Ns8QfmbfdNh/mJ9siDHSCWZXw2JwO3J7Iri3NvKh8oeaPFbR6jkykjCTS5Y1GKufCU/9QmCaz7x
 Eaq0iNlnD4Z3PdLOCYjSwc/ozaZ9gssVrsQgp1dGFCgu39kx6QkkEOaA5gsXRaZOki7ew33zsY4
 cCYl/ZxhCYUaOmodSvpxZgoFW8R30jNsPtRF2HeV2Fz6RDHYaLPZTbRWoEwMi7v7A3fAKuH2O29
 CZhj8xumdnpr+yOE/o0k5+FLjTJ72tqIuuQag67wAyPmQWwtt9jc62cew2EuAB+5444O9tD71cZ
 F0NV4202whbxo3fpoRA==
X-Proofpoint-ORIG-GUID: 9ljf8u6Y7N1h7rbHDWeKzOMSp6ZqsUyK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170156
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Sean,

Thanks for your feedback.

To address stack smashing, which occurs when the cell size is larger 
than 4 bytes, I will revert the `nvmem_cell_read()` call in 
`reboot_mode_get()` to pass `sizeof(*mode)` as the size, consistent with 
the original implementation.

Inside `nvmem_cell_read()`, will modify the validation check. Instead of 
enforcing `size == cell->size`, will check if `cell->size` is within the 
passed `size` (i.e., `cell->size <= size`) to correctly support our 
1-byte read case where the buffer is 4 bytes.
Also, i2c_eeprom_read() and misc_read() will continue to request a read 
for cell->size instead of the passed buffer size, ensuring we only read 
the valid data from the hardware.

Regarding the bit field logic, as you suggested will simplify the 
bit‑field handling to max u32 size, which significantly reduces the code 
complexity. Given this simplification, is it still necessary to keep 
this bit‑manipulation logic behind a separate config option?

Kindly confirm if this approach aligns with your expectations.


Thanks,
Aswin


On 2/13/2026 9:04 PM, Sean Anderson wrote:
> On 2/13/26 06:27, Aswin Murugan wrote:
>> NVMEM cells currently only support byte-level access. Many hardware
>> registers pack multiple fields into single bytes, requiring bit-level
>> granularity. For example, Qualcomm PMIC PON registers store a 7-bit
>> reboot reason field within a single byte, with bit 0 reserved for other
>> purposes.
>>
>> Add support for the optional 'bits' property in NVMEM cell device tree
>> bindings. This property specifies <bit_offset num_bits> to define a bit
>> field within the cell's register space.
>>
>> Implement multi-byte bit field support by porting bit manipulation
>> algorithms from the Linux kernel driver [1]:
>>
>> 1. nvmem_shift_read_buffer_in_place() - Extract bit fields from raw
>>     bytes by shifting and masking across byte boundaries. Handles fields
>>     that span multiple bytes.
>>
>> 2. nvmem_cell_prepare_write_buffer() - Perform Read-Modify-Write to
>>     preserve bits outside the target field. Read current values, mask to
>>     preserve adjacent bits, and combine with new value.
>>
>> Example device tree usage:
>>          reboot-reason@48 {
>>                  reg = <0x48 0x01>;
>>                  bits = <0x01 0x07>;  /* 7 bits starting at bit 1 */
>>          };
>>
>> This reads bits [7:1] from the byte at offset 0x48, leaving bit 0
>> untouched during write operations.
>>
>> Cells without the 'bits' property continue to work unchanged, ensuring
>> backward compatibility with existing device trees.
>>
>> [1] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/nvmem/core.c
>>
>> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> This seems like it adds a lot of calculations; have you looked at the 
> size
> increase? Maybe this should be a separate config, since the feature 
> does not
> seem too common.
>
> Actually, I think we could reduce the complexity quite a bit by refusing
> to process bits longer than a ulong. A quick grep through Linux's dts 
> shows
> that the largest bits is <6 12>. I don't really see any reason we need to
> support arbitrary bit extraction.
>
> There should also be a test for this. The existing code is lightly 
> tested by
> checking that mac addresses are loaded correctly. Maybe you can extend
> test/dm/reboot-mode.c.
>
>> ---
>>   drivers/misc/nvmem.c | 241 ++++++++++++++++++++++++++++++++++++++++---
>>   include/nvmem.h      |   4 +
>>   2 files changed, 231 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/misc/nvmem.c b/drivers/misc/nvmem.c
>> index 33e80858565..6a75c326189 100644
>> --- a/drivers/misc/nvmem.c
>> +++ b/drivers/misc/nvmem.c
>> @@ -12,52 +12,251 @@
>>   #include <dm/ofnode.h>
>>   #include <dm/read.h>
>>   #include <dm/uclass.h>
>> +#include <linux/bitops.h>
>> +#include <linux/kernel.h>
>> +
>> +/**
>> + * nvmem_shift_read_buffer_in_place() - Shift read buffer to extract 
>> bit field
>> + * @cell: NVMEM cell with bit field information
>> + * @buf: Buffer containing raw bytes read from NVMEM
>> + *
>> + * This function shifts and masks the buffer to extract only the 
>> bits specified
>> + * by cell->bit_offset and cell->nbits. It handles bit fields that 
>> span multiple
>> + * bytes by shifting bits across byte boundaries.
>> + *
>> + */
>> +static void nvmem_shift_read_buffer_in_place(struct nvmem_cell 
>> *cell, void *buf)
>> +{
>> +    u8 *prev_byte, *buf_ptr;
>> +    int i, extra, bit_offset = cell->bit_offset;
>> +    int bytes_needed;
>> +
>> +    bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, 
>> BITS_PER_BYTE);
>> +
>> +    prev_byte = buf_ptr = buf;
>> +    if (bit_offset) {
>> +        /* First byte: shift right by bit_offset */
>> +        *buf_ptr++ >>= bit_offset;
>> +
>> +        /* Process remaining bytes, combining bits across boundaries */
>> +        for (i = 1; i < bytes_needed; i++) {
>> +            /* Get bits from next byte and shift them towards MSB */
>> +            *prev_byte |= *buf_ptr << (BITS_PER_BYTE - bit_offset);
>> +
>> +            prev_byte = buf_ptr;
>> +            *buf_ptr++ >>= bit_offset;
>> +        }
>> +    } else {
>> +        /* Point to the MSB */
>> +        prev_byte += bytes_needed - 1;
>> +    }
>> +
>> +    /* Clear extra bytes if result fits in fewer bytes */
>> +    extra = bytes_needed - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
>> +    while (--extra >= 0)
>> +        *prev_byte-- = 0;
>> +
>> +    /* Clear MSB bits if any leftover in the last byte */
>> +    if (cell->nbits % BITS_PER_BYTE)
>> +        *prev_byte &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
>> +}
>> +
>> +/**
>> + * nvmem_cell_prepare_write_buffer() - Prepare buffer for writing 
>> bit field
>> + * @cell: NVMEM cell with bit field information
>> + * @buf: Buffer containing value to write
>> + * @size: Size of buf
>> + * @data: Output buffer with prepared data for writing
>> + *
>> + * This function performs Read-Modify-Write to preserve bits outside 
>> the
>> + * specified bit field. It reads current values, modifies only the 
>> target
>> + * bits, and prepares the complete bytes for writing back.
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +static int nvmem_cell_prepare_write_buffer(struct nvmem_cell *cell,
>> +                       const void *buf, size_t size,
>> +                       u8 *data)
>> +{
>> +    int i, rc, nbits, bit_offset = cell->bit_offset;
>> +    int bytes_needed;
>> +    u8 current_val, *prev_byte, *buf_ptr, prev_byte_val, prev_bits;
>> +
>> +    nbits = cell->nbits;
>> +    bytes_needed = DIV_ROUND_UP(nbits + bit_offset, BITS_PER_BYTE);
>> +
>> +    memcpy(data, buf, size);
>> +    prev_byte = buf_ptr = data;
>> +
>> +    if (bit_offset) {
>> +        prev_byte_val = *buf_ptr;
>> +        *buf_ptr <<= bit_offset;
>> +
>> +        /* Setup the first byte with LSB bits from NVMEM */
>> +        switch (cell->nvmem->driver->id) {
>> +        case UCLASS_I2C_EEPROM:
>> +            rc = i2c_eeprom_read(cell->nvmem, cell->offset, 
>> &current_val, 1);
>> +            break;
>> +        case UCLASS_MISC:
>> +            rc = misc_read(cell->nvmem, cell->offset, &current_val, 1);
>> +            if (rc < 0)
>> +                return rc;
>> +            if (rc != 1)
>> +                return -EIO;
>> +            rc = 0;
>> +            break;
>> +        case UCLASS_RTC:
>> +            rc = dm_rtc_read(cell->nvmem, cell->offset, 
>> &current_val, 1);
>> +            break;
>> +        default:
>> +            return -ENOSYS;
>> +        }
>
> Can you use nvmem_cell_read for this to reduce duplication?
>
>> +
>> +        if (rc)
>> +            return rc;
>> +
>> +        *buf_ptr++ |= GENMASK(bit_offset - 1, 0) & current_val;
>> +
>> +        /* Setup rest of the bytes if any */
>> +        for (i = 1; i < bytes_needed; i++) {
>> +            /* Get last byte bits and shift them towards LSB */
>> +            prev_bits = prev_byte_val >> (BITS_PER_BYTE - 1 - 
>> bit_offset);
>> +            prev_byte_val = *buf_ptr;
>> +            prev_byte = buf_ptr;
>> +            *buf_ptr <<= bit_offset;
>> +            *buf_ptr++ |= prev_bits;
>> +        }
>> +    }
>> +
>> +    /* If it's not end on byte boundary */
>> +    if ((nbits + bit_offset) % BITS_PER_BYTE) {
>> +        /* Setup the last byte with MSB bits from NVMEM */
>> +        switch (cell->nvmem->driver->id) {
>> +        case UCLASS_I2C_EEPROM:
>> +            rc = i2c_eeprom_read(cell->nvmem,
>> +                         cell->offset + bytes_needed - 1,
>> +                         &current_val, 1);
>> +            break;
>> +        case UCLASS_MISC:
>> +            rc = misc_read(cell->nvmem,
>> +                       cell->offset + bytes_needed - 1,
>> +                       &current_val, 1);
>> +            if (rc < 0)
>> +                return rc;
>> +            if (rc != 1)
>> +                return -EIO;
>> +            rc = 0;
>> +            break;
>> +        case UCLASS_RTC:
>> +            rc = dm_rtc_read(cell->nvmem,
>> +                     cell->offset + bytes_needed - 1,
>> +                     &current_val, 1);
>> +            break;
>> +        default:
>> +            return -ENOSYS;
>> +        }
>> +
>> +        if (rc)
>> +            return rc;
>> +
>> +        *prev_byte |= GENMASK(7, (nbits + bit_offset) % 
>> BITS_PER_BYTE) & current_val;
>> +    }
>> +
>> +    return 0;
>> +}
>>     int nvmem_cell_read(struct nvmem_cell *cell, void *buf, size_t size)
>>   {
>> +    u8 data[size];
>
> No alloca.
>
>> +    int bytes_needed;
>> +    int ret;
>> +
>>       dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, 
>> cell->offset, size);
>
> Please update these.
>
>> +
>>       if (size != cell->size)
>>           return -EINVAL;
>>   +    /* Calculate how many bytes we need to read */
>> +    if (cell->nbits > 0) {
>
> just if (cell->nbits) for clarity please
>
> (ditto for elsewhere)
>
>> +        bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, 
>> BITS_PER_BYTE);
>> +        if (bytes_needed > sizeof(data))
>> +            return -EINVAL;
>> +    } else {
>> +        bytes_needed = size;
>
> This should always be true even when nbits != 0, as bits specifies the 
> offset/size
> "within the address range specified by reg." This will allow you to 
> use the original buffer.
>
>> +    }
>> +
>>       switch (cell->nvmem->driver->id) {
>>       case UCLASS_I2C_EEPROM:
>> -        return i2c_eeprom_read(cell->nvmem, cell->offset, buf, size);
>> -    case UCLASS_MISC: {
>> -        int ret = misc_read(cell->nvmem, cell->offset, buf, size);
>> -
>> +        ret = i2c_eeprom_read(cell->nvmem, cell->offset, data, 
>> bytes_needed);
>> +        break;
>> +    case UCLASS_MISC:
>> +        ret = misc_read(cell->nvmem, cell->offset, data, bytes_needed);
>>           if (ret < 0)
>>               return ret;
>> -        if (ret != size)
>> +        if (ret != bytes_needed)
>>               return -EIO;
>> -        return 0;
>> -    }
>> +        ret = 0;
>> +        break;
>>       case UCLASS_RTC:
>> -        return dm_rtc_read(cell->nvmem, cell->offset, buf, size);
>> +        ret = dm_rtc_read(cell->nvmem, cell->offset, data, 
>> bytes_needed);
>> +        break;
>>       default:
>>           return -ENOSYS;
>>       }
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (cell->nbits > 0) {
>> +        /* Extract bit field from raw bytes */
>> +        nvmem_shift_read_buffer_in_place(cell, data);
>> +        /* Copy only the bytes containing the bit field result */
>> +        memcpy(buf, data, DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE));
>> +    } else {
>> +        memcpy(buf, data, size);
>> +    }
>> +
>> +    return 0;
>>   }
>>     int nvmem_cell_write(struct nvmem_cell *cell, const void *buf, 
>> size_t size)
>>   {
>> +    u8 data[size];
>
> Again, no alloca. Limit the size for cells with bits and you can use a 
> static
> allocation on the stack.
>
>> +    int bytes_needed;
>> +    int ret;
>> +
>>       dev_dbg(cell->nvmem, "%s: off=%u size=%zu\n", __func__, 
>> cell->offset, size);
>> +
>>       if (size != cell->size)
>>           return -EINVAL;
>>   +    if (cell->nbits > 0) {
>> +        bytes_needed = DIV_ROUND_UP(cell->nbits + cell->bit_offset, 
>> BITS_PER_BYTE);
>> +        if (bytes_needed > sizeof(data))
>> +            return -EINVAL;
>> +
>> +        /* Prepare write buffer with Read-Modify-Write */
>> +        ret = nvmem_cell_prepare_write_buffer(cell, buf, size, data);
>> +        if (ret)
>> +            return ret;
>> +    } else {
>> +        bytes_needed = size;
>> +        memcpy(data, buf, size);
>> +    }
>> +
>>       switch (cell->nvmem->driver->id) {
>>       case UCLASS_I2C_EEPROM:
>> -        return i2c_eeprom_write(cell->nvmem, cell->offset, buf, size);
>> +        return i2c_eeprom_write(cell->nvmem, cell->offset, data, 
>> bytes_needed);
>>       case UCLASS_MISC: {
>> -        int ret = misc_write(cell->nvmem, cell->offset, buf, size);
>> -
>> +        ret = misc_write(cell->nvmem, cell->offset, data, 
>> bytes_needed);
>>           if (ret < 0)
>>               return ret;
>> -        if (ret != size)
>> +        if (ret != bytes_needed)
>>               return -EIO;
>>           return 0;
>>       }
>>       case UCLASS_RTC:
>> -        return dm_rtc_write(cell->nvmem, cell->offset, buf, size);
>> +        return dm_rtc_write(cell->nvmem, cell->offset, data, 
>> bytes_needed);
>>       default:
>>           return -ENOSYS;
>>       }
>> @@ -121,13 +320,27 @@ int nvmem_cell_get_by_index(struct udevice 
>> *dev, int index,
>>         offset = ofnode_get_addr_size_index_notrans(args.node, 0, 
>> &size);
>>       if (offset == FDT_ADDR_T_NONE || size == FDT_SIZE_T_NONE) {
>> -        dev_dbg(cell->nvmem, "missing address or size for %s\n",
>> +        dev_err(cell->nvmem, "missing address or size for %s\n",
>>               ofnode_get_name(args.node));
>>           return -EINVAL;
>>       }
>>         cell->offset = offset;
>>       cell->size = size;
>> +
>> +    ret = ofnode_read_u32_index(args.node, "bits", 0, 
>> &cell->bit_offset);
>> +    if (ret) {
>> +        cell->bit_offset = 0;
>> +        cell->nbits = 0;
>> +    } else {
>> +        ret = ofnode_read_u32_index(args.node, "bits", 1, 
>> &cell->nbits);
>> +        if (ret)
>> +            return -EINVAL;
>> +
>> +        if (cell->bit_offset + cell->nbits > cell->size * 8)
>> +            return -EINVAL;
>> +    }
>> +
>>       return 0;
>>   }
>>   diff --git a/include/nvmem.h b/include/nvmem.h
>> index e6a8a98828b..dd82122f16f 100644
>> --- a/include/nvmem.h
>> +++ b/include/nvmem.h
>> @@ -26,11 +26,15 @@
>>    * @nvmem: The backing storage device
>>    * @offset: The offset of the cell from the start of @nvmem
>>    * @size: The size of the cell, in bytes
>> + * @bit_offset: Bit offset within the cell (0 for byte-level access)
>> + * @nbits: Number of bits to use (0 for byte-level access)
>>    */
>>   struct nvmem_cell {
>>       struct udevice *nvmem;
>>       unsigned int offset;
>>       size_t size;
>> +    unsigned int bit_offset;
>> +    unsigned int nbits;
>>   };
>
> Please also update the documentation for read/write.
>
>>   struct udevice;
>
